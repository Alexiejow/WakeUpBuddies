import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wakeupbuddies/models/message.dart';
import 'package:wakeupbuddies/models/user.dart';
import 'package:wakeupbuddies/models/wakeup.dart';
import 'package:wakeupbuddies/utils/utilities.dart';



class FirebaseMethods {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Userr user = Userr();

  Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = await _auth.currentUser;
    return currentUser;
  }

  Future<User> signIn() async {

    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(

      accessToken: _signInAuthentication.accessToken,
      idToken: _signInAuthentication.idToken

    );

    User user = (await _auth.signInWithCredential(credential)).user;
    return user;
  }

  Future<bool> authenticateUser(User user) async {

    QuerySnapshot result = await firestore
      .collection("users")
      .where("email", isEqualTo: user.email)
        .get();

    final List<DocumentSnapshot> docs = result.docs;

      return docs.length == 0 ? true : false;
  }

  Future<void> addDataToDb(User currentUser) async {
    String username = Utils.getUsername(currentUser.email);

    user = Userr(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.displayName,
        profilePhoto: currentUser.photoURL,
        username: username);

    firestore
        .collection("users")
        .doc(currentUser.uid)
        .set(user.toMap(user));
  }

  Future<void> signOut() async{
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<List<Userr>> fetchAllUsers(User currentUser) async {
    List<Userr> userList = List<Userr>();

    QuerySnapshot querySnapshot =
    await firestore.collection("users").get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != currentUser.uid) {
        userList.add(Userr.fromMap(querySnapshot.docs[i].data()));
        //TODO: might not work
      }
    }
    return userList;
  }

  Future<void> addWakeupToDb(
      Wakeup wakeup, Userr sender, Userr receiver) async {
    var map = wakeup.toMap();

    await firestore
        .collection("wakeups")
        .doc(wakeup.senderId)
        .collection(wakeup.receiverId)
        .add(map);

    return await firestore
        .collection("wakeups")
        .doc(wakeup.receiverId)
        .collection(wakeup.senderId)
        .add(map);
  }

  Future<void> addMessageToDb(
      Message message, Userr sender, Userr receiver) async {
    var map = message.toMap();

    await firestore
        .collection("messages")
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);

    return await firestore
        .collection("messages")
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }
}