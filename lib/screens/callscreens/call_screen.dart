import 'package:flutter/material.dart';
import 'package:wakeupbuddies/models/call.dart';
import 'package:wakeupbuddies/resources/call_methods.dart';

class CallScreen extends StatefulWidget {
  final Call call;

  CallScreen({
    @required this.call,
  });

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final CallMethods callMethods = CallMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Text(
            "Call has been made",
          ),
          MaterialButton(
            color: Colors.red,
            child: Icon(
                Icons.call_end,
                color: Colors.white),
            onPressed: (){
              callMethods.endCall(call: widget.call);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
