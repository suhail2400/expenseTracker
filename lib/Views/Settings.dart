import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Settings'),
      ),
      body: Column(children: [
        ListTile(
          leading: Icon(Icons.language),
          title:Text('Language'),
          subtitle: Text('English'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.dark_mode),
          title: Text('Theme'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.notifications),
          title:Text('Notifications')
        ),
        Divider(),
      ]),
    );
  }
}