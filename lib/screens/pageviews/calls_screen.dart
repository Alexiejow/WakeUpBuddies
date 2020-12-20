import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wakeupbuddies/utils/universal_variables.dart';

class CallsScreen extends StatefulWidget {
  @override
  _CallsScreenState createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      appBar: AppBar(
        backgroundColor: UniversalVariables.blackColor,
        title: Text("New Wake-up", style: TextStyle(color: Colors.white),),
      ),
    );
  }
}

