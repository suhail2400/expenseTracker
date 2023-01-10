import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kash/Views/HomePage.dart';
import 'package:kash/Views/Register.dart';

import '../utils.dart';

class LoginPage extends StatefulWidget {

   LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    
    final EmailController = TextEditingController();

    final PasswordController = TextEditingController();
  
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: TextFormField(
            controller: EmailController,
            decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.blue),
            hintText: "Enter your email"
          ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: TextFormField(
            controller: PasswordController,
            decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.blue),
            hintText: "Enter your password"
          ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text('FORGOT PASSWORD?',style:TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
        ),
        InkWell(
          onTap:SignIn,
          child: Container(
              height: 50,
              width: 90,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Text('Sign In',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),),
          ),
        ),
        InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder:(context) =>  Register()));
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text('New User?',style:TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
          ),
        ),
      ]),
    );
  }

   Future SignIn() async {
   try {
    print('Hi');
    await FirebaseAuth.instance.signInWithEmailAndPassword(
    email:EmailController.text.trim() ,
    password:PasswordController.text.trim());
    Navigator.of(context).push(MaterialPageRoute(builder:(context) => const HomePage()));
   } on FirebaseAuthException catch(e) {
    print(e);
    u1.showSnackBar(e.message);
   }
}
}