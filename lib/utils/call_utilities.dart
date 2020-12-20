import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wakeupbuddies/models/call.dart';
import 'package:wakeupbuddies/models/user.dart';
import 'package:wakeupbuddies/resources/call_methods.dart';
import 'package:wakeupbuddies/screens/callscreens/call_screen.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({Userr from, Userr to, context}) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profilePhoto,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(call: call),
          ));
    }
  }
}