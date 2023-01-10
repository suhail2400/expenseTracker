import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: Center(
        child: Container(
              height: 200,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  blurStyle: BlurStyle.outer,
                  offset: const Offset(0,2)
                ),
              ],
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Hola!!!\n',style: TextStyle(fontWeight: FontWeight.bold),),
              Text('We help to manage your expense\n',style: TextStyle(fontWeight: FontWeight.bold),),
              Text('mail us:',style: TextStyle(fontWeight: FontWeight.bold),),
              Text('app21kash@gmail.com\n',style: TextStyle(fontWeight: FontWeight.bold),),
              Text('Version v1.0',style: TextStyle(fontWeight: FontWeight.bold),),
            ],)
        ),
      ),
    );
  }
}