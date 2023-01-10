import 'package:flutter/material.dart';
import 'package:kash/Views/AddCustomer.dart';
import 'package:kash/Views/CustomerList.dart';

class BusinessPage extends StatelessWidget {
  const BusinessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business')),
      body:Column(
        children: [
          SizedBox(height: 20,),
          Center(
            child: Container(
              height: 200,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  width: 5,
                ),              
              ),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text('Total Credit',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Text('5125',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              ],)
            ),
          ),
          SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder:(context) => const AddCustomer()));
              },
              child: Container(
              padding: EdgeInsets.all(10),
              height: 50,
              width: 190,
              decoration: BoxDecoration(
                color:Colors.blue,
                borderRadius: BorderRadius.circular(50)),
              child: Center(child: Text('Add Customers',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),))
                      ),
            ),
          SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder:(context) => const CustomerList()));
              },              
              child: Container(
              padding: EdgeInsets.all(10),
              height: 50,
              width: 190,
              decoration: BoxDecoration(
                color:Colors.blue,
                borderRadius: BorderRadius.circular(50)),
              child: Center(child: Text('View Customers',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),))
                      ),
            ),
        ],
      ),
    );
  }
}