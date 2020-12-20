import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wakeupbuddies/utils/universal_variables.dart';

import '../../DateTimePicker.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();


}

class _ContactsScreenState extends State<ContactsScreen> {

  final DateTimePicker _datetime = DateTimePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      appBar: AppBar(
        backgroundColor: UniversalVariables.blackColor,
        title: Text("oomph", style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
