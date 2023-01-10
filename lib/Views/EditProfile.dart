import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    Map? data;

    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController occupationController = TextEditingController();
    TextEditingController accountDetailsControler = TextEditingController();


    return Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: Column(children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: TextFormField(
              controller: phoneController,
              keyboardType:TextInputType.phone,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintStyle: TextStyle(color: Colors.black),
                hintText: "Phone number",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: TextFormField(
              controller: occupationController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintStyle: TextStyle(color: Colors.black),
                hintText: "Occupation",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: TextFormField(
              controller: accountDetailsControler,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintStyle: TextStyle(color: Colors.black),
                hintText: "Account Details",
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              Map<String, dynamic> Data = {
                if(nameController.text!="")
                "name": nameController.text,
                if(phoneController.text!="")
                "phoneNumber": int.parse(phoneController.text),
                if(occupationController.text!="")
                "occupation": occupationController.text,
                if(accountDetailsControler.text!="")
                "accountDetails": accountDetailsControler.text,
              };

              CollectionReference collectionReference =
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection('profile');
              // collectionReference.snapshots().listen((snapshot) {
              //   setState(() {
              //     data = snapshot.docs[0].data() as Map?;
              //   });
              // });
              QuerySnapshot querySnapshot = await collectionReference.get();
              querySnapshot.docs[0].reference.update(Data);
            },
            child: Container(
                padding: EdgeInsets.all(10),
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                    child: Text(
                  'Update',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ))),
          ),
          
        ]));
  }
}
