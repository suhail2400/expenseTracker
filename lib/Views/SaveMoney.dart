import 'package:flutter/material.dart';

class SaveMoney extends StatelessWidget {
  const SaveMoney({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Save Money')
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: TextFormField(
              decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              hintStyle: TextStyle(color: Colors.black),
              hintText: "Purpose"
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              hintStyle: TextStyle(color: Colors.black),
              hintText: "Target Amount",
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              hintStyle: TextStyle(color: Colors.black),
              hintText: "Time Period",
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              hintStyle: TextStyle(color: Colors.black),
              hintText: "Basic Salary",
            ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              color:Colors.blue,
              borderRadius: BorderRadius.circular(50)),
            child: Center(child: Text('Generate Plan',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),))
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(10),
            height: 50,
            width: 120,
            decoration: BoxDecoration(
              color:Colors.blue,
              borderRadius: BorderRadius.circular(50)),
            child: Center(child: Text('View Plan',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),))
          )
          ]
        ),
      ));
  }
}