import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kash/Views/LoginPage.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import '../utils.dart';
import 'HomePage.dart';

class Register extends StatelessWidget {


   Register({Key? key}) : super(key: key);

    final EmailController = TextEditingController();
    final PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Text('REGISTER',style: TextStyle(fontWeight: FontWeight.bold),),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: TextFormField(
            controller: EmailController,
            decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.blue),
            hintText: "Email"
          ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: TextFormField(
            controller: PasswordController,
            decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.blue),
            hintText: "Password",
          ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child:FlutterPwValidator(
              controller:PasswordController,
              minLength: 6,
              uppercaseCharCount: 1,
              numericCharCount: 1,
              specialCharCount: 1,
              width: 400,
              height: 150,
              onSuccess:(){},
              onFail:(){},
          )
        ),
        InkWell(
          onTap: signUp(context),
          child: Container(
              height: 50,
              width: 90,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50),
              ),
              child: Center(child: Text('Sign Up',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),)),
          ),
        ),
        InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder:(context) => LoginPage()));
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text('Already have an account?',style:TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
          ),
        ),
      ]),
    );
  }

   signUp(BuildContext context) async {
   try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email:EmailController.text.trim() ,
    password:PasswordController.text.trim());
     FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection('profile').add({
                        "name":"",
                        "phoneNumber":"",
                        "occupation":"",
                         "accountDetails":""
                      });
    Navigator.of(context).push(MaterialPageRoute(builder:(context) => const HomePage()));
   } on FirebaseAuthException catch(e) {
    print(e);
    u1.showSnackBar(e.message);
   }
}
}