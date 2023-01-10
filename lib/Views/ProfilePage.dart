import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
   ProfilePage({Key? key}) : super(key: key);

      final Stream<QuerySnapshot> profile = FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection('profile').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text('Profile')),
      body: StreamBuilder(
        stream: profile,
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
        final data = snapshot.requireData;
              return ListView.builder(
                  itemCount:data.size,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text("Name: ${data.docs[index]['name']}",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,textScaleFactor:1.5,),
                            SizedBox(height: 5,),
                            Text("PhoneNumber: ${data.docs[index]['phoneNumber'].toString()}",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,textScaleFactor: 1.5,),
                            SizedBox(height: 5,),
                            Text("Occupation: ${data.docs[index]['occupation']}",style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5,),
                            SizedBox(height: 5,),
                            Text("AccountDetails: ${data.docs[index]['accountDetails']}",style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5,)
                        ]
                      ),
                    );
      });
        }));
  }
}