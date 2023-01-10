import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kash/Views/ExpensesList.dart';
import 'package:kash/Views/ProfilePage.dart';
import 'NavigationMenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final referenceController = TextEditingController();
  final expenseController = TextEditingController();
  DateTime date = DateTime.now();
  final items = ['Rent','Food','Books','medical','household','other'];
  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationMenu(),
      appBar: AppBar(
        title: Text('Expense Analyser'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder:(context) =>  ProfilePage()));
                },
                icon: Icon(Icons.person)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical:15),
              child: TextFormField(
                controller: expenseController,
                decoration: InputDecoration(
                  label:Text('Enter your expense'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),
            ),
            Text('${date.day}/${date.month}/${date.year}',
            style: TextStyle(fontSize: 32),),
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  context: context, 
                  initialDate: date, 
                  firstDate: DateTime(2022), 
                  lastDate:DateTime(2040)
                  );
      
                if(newDate == null) return;
      
                setState(() {
                  date = newDate;
                });
              },
             child: Text('Select Date')),
             Padding(padding: EdgeInsets.symmetric(horizontal: 20),
               child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Category",
                ),
                value:value,
                items: items.map(buildMenuItem).toList(), 
               onChanged:(value) => setState(() => this.value = value,)
               ),
             ),
             Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical:15),
              child: TextFormField(
                controller: referenceController,
                decoration: InputDecoration(
                  label:Text('Reference'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: () async {
              CollectionReference expense =FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection('expenses');
              expense.add({
                "expense": int.parse(expenseController.text),
                "date": date,
                "reference": referenceController.text,
                "category":value
              }); 
                _dialogBuilder(context);
              },
              child: Container(
              padding: EdgeInsets.all(10),
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                color:Colors.blue,
                borderRadius: BorderRadius.circular(50)),
              child: Center(child: Text('Add Expense',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),))
                      ),
            ),
          SizedBox(height: 20,),
          InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExpensesList()));
          },
            child: Container(
              padding: EdgeInsets.all(10),
              height: 50,
              width: 120,
              decoration: BoxDecoration(
                color:Colors.blue,
                borderRadius: BorderRadius.circular(50)),
              child: Center(child: Text('View/Edit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),))
            ),
          ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) =>
    DropdownMenuItem(
    value:item,
    child: Text(item,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),);


    Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Expense Added'),
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
