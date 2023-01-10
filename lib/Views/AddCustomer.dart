import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddCustomer extends StatelessWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController creditController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title:Text('Add Customer'),
      ),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical:15),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  label:Text('Customer name'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),
            ),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical:15),
              child: TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  label:Text('Phone Number'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),
            ),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical:15),
              child: TextFormField(
                controller: creditController,
                decoration: InputDecoration(
                  label:Text('Credit'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
              Map<String, dynamic> Data = {
                "name": nameController.text,
                "phoneNumber": int.parse(phoneController.text),
                "credit": int.parse(creditController.text),
              };
                await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser?.email)
                      .collection('customers').add(Data);
                  _dialogBuilder(context);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                height: 50,
                width: 190,
                decoration: BoxDecoration(
                  color:Colors.blue,
                  borderRadius: BorderRadius.circular(50)),
                child: Center(child: Text('Add Customer',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),))
              ),
            ),
        ],
      )
    );
  }

    Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Customer Added'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ]
        );
      }
    );
    }
}