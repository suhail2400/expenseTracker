import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kash/Views/AboutUs.dart';
import 'package:kash/Views/BusinessPage.dart';
import 'package:kash/Views/SaveMoney.dart';
import 'package:kash/Views/Settings.dart';
import 'EditProfile.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }


  Widget buildHeader(BuildContext context) => Container(
    padding:EdgeInsets.only(
      top:MediaQuery.of(context).padding.top,
    ) ,
  );

  Widget buildMenuItems(BuildContext context) =>
   Container(
    padding: const EdgeInsets.all(24),
     child: Wrap(
      runSpacing: 16,
      children: [
      ListTile(
        leading: const Icon(Icons.manage_accounts),
        title:const Text('Edit Profile',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder:(context) => const EditProfile()));
        },
      ),
      ListTile(
        leading: const Icon(Icons.storefront),
        title:const Text('Business',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder:(context) => const BusinessPage()));
        },
      ),   
       ListTile(
        leading: const Icon(Icons.savings),
        title:const Text('Save Money',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder:(context) => const SaveMoney()));
        },
      ),    
      ListTile(
        leading: const Icon(Icons.settings),
        title:const Text('Settings',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder:(context) => const Settings()));
        },
      ),    
      ListTile(
        leading: const Icon(Icons.groups),
        title:const Text('About Us',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder:(context) => const AboutUs()));
        },
      ),    
      ListTile(
        leading: const Icon(Icons.logout),
        title:const Text('LogOut',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        onTap: (){
          FirebaseAuth.instance.signOut();
        },
      ),
  ],),
   );
}