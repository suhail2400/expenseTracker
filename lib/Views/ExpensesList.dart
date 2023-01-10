import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({Key? key}) : super(key: key);

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {

  final Expenses = <int>[];
  List dates = [];

  Map ? data;
  CollectionReference collectionReference = FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection('expenses');
  final Stream<QuerySnapshot> expenses = FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection('expenses').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Customer List')),
        body: StreamBuilder<QuerySnapshot>(
            stream:expenses,
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
                  DateTime myDate = (snapshot.data?.docs[index]['date']).toDate();
                    return Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
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
                          Text(data.docs[index]['category']),
                          Text(data.docs[index]['expense'].toString()),
                          Text('${myDate.day}/${myDate.month}/${myDate.year}'),
                          Text(data.docs[index]['reference']),
                          IconButton(onPressed: (){
                            _dialogBuilder(context,index,myDate);
                          }, icon:Icon(Icons.edit))
                        ],
                      ),
                    );
                  });
            }));
  }

   Future<void> _dialogBuilder(BuildContext context, int index, DateTime date) {
    final categoryController = TextEditingController();
    final expenseController = TextEditingController();
    final referenceController = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Expense'),
          content: Container(
            height: 200,
            child: Column(
              children: [
                TextFormField(
                  controller:categoryController,
                  decoration: InputDecoration(hintText: 'Category'),
                ),
                TextFormField(
                  controller: expenseController,
                  decoration: InputDecoration(hintText: 'Expense'),
                ),
                TextFormField(
                  controller: referenceController,
                  decoration: InputDecoration(hintText: 'Reference'),
                ),        
                ElevatedButton(onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  initialDate:date,
                  context: context, 
                  firstDate: DateTime(2022), 
                  lastDate:DateTime(2040)
                  );
      
                if(newDate == null) return;
      
                setState(() {
                  date = newDate;
                });
              }, child:Text('Change Date'))
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
                if(categoryController.text!="")
                "category": categoryController.text,
                if(expenseController.text!="")
                "expense": int.parse(expenseController.text),
                "date": date,
                if(referenceController.text!="")
                "reference": referenceController.text,
              };


              collectionReference.snapshots().listen((snapshot) {
                setState(() {
                  data = snapshot.docs[index].data() as Map;
                });
              });
              QuerySnapshot querySnapshot = await collectionReference.get();
              querySnapshot.docs[index].reference.update(Data);
              Navigator.of(context).pop();
            },
            ),
            IconButton(
                onPressed:() async {
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

