import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wakeupbuddies/constants/strings.dart';
import 'package:wakeupbuddies/models/message.dart';
import 'package:wakeupbuddies/models/user.dart';
import 'package:wakeupbuddies/models/wakeup.dart';
import 'package:wakeupbuddies/utils/utilities.dart';



class FirebaseMethods {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final Firestore _firestore = Firestore.instance;

  static final CollectionReference _userCollection =
  _firestore.collection(USERS_COLLECTION);

  Userr user = Userr();

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }

  Future<FirebaseUser> signIn() async {

    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(

      accessToken: _signInAuthentication.accessToken,
      idToken: _signInAuthentication.idToken

    );

    FirebaseUser user = (await _auth.signInWithCredential(credential));
    return user;
  }

  Future<bool> authenticateUser(FirebaseUser user) async {

    QuerySnapshot result = await _firestore
      .collection("users")
      .where("email", isEqualTo: user.email)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

      return docs.length == 0 ? true : false;
  }

  Future<void> addDataToDb(FirebaseUser currentUser) async {
    String username = Utils.getUsername(currentUser.email);

    user = Userr(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.displayName,
        profilePhoto: currentUser.photoUrl,
        username: username);

    _firestore
        .collection("users")
        .document(currentUser.uid)
        .setData(user.toMap(user));
  }

  Future<void> signOut() async{
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<List<Userr>> fetchAllUsers(FirebaseUser currentUser) async {
    List<Userr> userList = List<Userr>();

    QuerySnapshot querySnapshot =
    await _firestore.collection("users").getDocuments();
    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].documentID != currentUser.uid) {
        userList.add(Userr.fromMap(querySnapshot.documents[i].data));
        //TODO: might not work
      }
    }
    return userList;
  }

  Future<Userr> getUserDetails() async {
    FirebaseUser currentUser = await getCurrentUser();

    DocumentSnapshot documentSnapshot =
    await _userCollection.document(currentUser.uid).get();

    return Userr.fromMap(documentSnapshot.data);
  }

  Future<void> addWakeupToDb(
      Wakeup wakeup, Userr sender, Userr receiver) async {
    var map = wakeup.toMap();

    await _firestore
        .collection("wakeups")
        .document(wakeup.senderId)
        .collection(wakeup.receiverId)
        .add(map);

    return await _firestore
        .collection("wakeups")
        .document(wakeup.receiverId)
        .collection(wakeup.senderId)
        .add(map);
  }

  Future<void> addMessageToDb(
      Message message, Userr sender, Userr receiver) async {
    var map = message.toMap();

    await _firestore
        .collection("messages")
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    return await _firestore
        .collection("messages")
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }
}