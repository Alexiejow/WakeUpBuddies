import 'package:wakeupbuddies/models/user.dart';
import 'package:wakeupbuddies/resources/firebase_repository.dart';
import 'package:flutter/widgets.dart';


class UserProvider with ChangeNotifier {
  Userr _user;
  FirebaseRepository _firebaseRepository = FirebaseRepository();

  Userr get getUser => _user;

  void refreshUser() async {
    Userr user = await _firebaseRepository.getUserDetails();
    _user = user;
    notifyListeners();
  }

}
