import 'package:cloud_firestore/cloud_firestore.dart';

class Wakeup {
  String senderId;
  String receiverId;
  String type;
  String wakeup;
  FieldValue timestamp;
  String photoUrl;

  Wakeup({this.senderId, this.receiverId, this.type, this.wakeup, this.timestamp});

  //Will be only called when you wish to send an image
  Wakeup.imageMessage({this.senderId, this.receiverId, this.wakeup, this.type, this.timestamp, this.photoUrl});

  Map toMap() {
    var map = Map<String, dynamic>();
    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['type'] = this.type;
    map['wakeup'] = this.wakeup;
    map['timestamp'] = this.timestamp;
    return map;
  }

  Wakeup fromMap(Map<String, dynamic> map) {
    Wakeup _wakeup = Wakeup();
    _wakeup.senderId = map['senderId'];
    _wakeup.receiverId = map['receiverId'];
    _wakeup.type = map['type'];
    _wakeup.wakeup = map['wakeup'];
    _wakeup.timestamp = map['timestamp'];
    return _wakeup;
  }


}