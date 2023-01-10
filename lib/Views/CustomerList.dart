import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {

  CollectionReference collectionReference = FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection('customers');
  Map ? data;
  final Stream<QuerySnapshot> customers = FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection('customers').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Customer List')),
        body: StreamBuilder<QuerySnapshot>(
            stream:customers,
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data = snapshot.requireData;
              return ListView.builder(
                  itemCount:data.size,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0.5,
                              blurRadius: 5,
                              blurStyle: BlurStyle.outer,
                              offset: const Offset(0, 2)),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(data.docs[index]['name']),
                          Text(data.docs[index]['phoneNumber'].toString()),
                          Text(data.docs[index]['credit'].toString()),
                          IconButton(
                              onPressed: () => _dialogBuilder(context,index),
                              icon: Icon(Icons.edit))
                        ],
                      ),
                    );
                  });
            }));
  }

  Future<void> _dialogBuilder(BuildContext context, int index) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final nameController = TextEditingController();
        final phoneController = TextEditingController();
        final creditController = TextEditingController();
        return AlertDialog(
          title: const Text('Edit Customer'),
          content: Container(
            height: 150,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(hintText: 'Phone'),
                ),
                TextFormField(
                  controller: creditController,
                  decoration: InputDecoration(hintText: 'Credit'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
              Map<String, dynamic> Data = {
                if(nameController.text!="")
                "name": nameController.text,
                if(phoneController.text!="")
                "phoneNumber": int.parse(phoneController.text),
                if(creditController.text!="")
                "credit":int.parse(creditController.text),
              };
              collectionReference.snapshots().listen((snapshot) {
                setState(() {
                  data = snapshot.docs[index].data() as Map?;
                });
              });
              QuerySnapshot querySnapshot = await collectionReference.get();
              querySnapshot.docs[index].reference.update(Data);
              Navigator.of(context).pop();
            },
            ),
            IconButton(
                onPressed: () async {
                   QuerySnapshot querySnapshot = await collectionReference.get();
                   querySnapshot.docs[index].reference.delete();
                   Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
        );
      },
    );
  }
}
