import 'package:firebase_auth/firebase_auth.dart';
import 'package:wakeupbuddies/models/message.dart';
import 'package:wakeupbuddies/models/user.dart';
import 'package:wakeupbuddies/models/wakeup.dart';
import 'package:wakeupbuddies/resources/firebase_methods.dart';

class FirebaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<User> getCurrentUser() =>_firebaseMethods.getCurrentUser();

  Future<Userr> getUserDetails() => _firebaseMethods.getUserDetails();

  Future<User> signIn() => _firebaseMethods.signIn();

  Future<bool> authenticateUser(User user) =>
      _firebaseMethods.authenticateUser(user);

  Future<void> addDataToDb(User user) => _firebaseMethods.addDataToDb(user);

  Future<void> signOut() => _firebaseMethods.signOut();

  Future<List<Userr>> fetchAllUsers(User user) =>
      _firebaseMethods.fetchAllUsers(user);

  Future<void> addMessageToDb(Message message, Userr sender, Userr receiver) =>
      _firebaseMethods.addMessageToDb(message, sender, receiver);

  Future<void> addWakeupToDb(Wakeup wakeup, Userr sender, Userr receiver) =>
      _firebaseMethods.addWakeupToDb(wakeup, sender, receiver);
}