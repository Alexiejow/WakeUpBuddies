import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:wakeupbuddies/provider/user_provider.dart';
import 'package:wakeupbuddies/resources/firebase_repository.dart';
import 'package:wakeupbuddies/screens/home_screen.dart';
import 'package:wakeupbuddies/screens/login_screen.dart';
import 'package:wakeupbuddies/screens/search_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();*/
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  final FirebaseMessaging _messaging = FirebaseMessaging();

  @override
  void initState(){
    super.initState();

    _messaging.getToken().then((token) {
      print(token);
    });
  }

  FirebaseRepository _repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: "WakeUp Buddies",
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/search_screen': (context) => SearchScreen(),
        },
        theme: ThemeData(
            brightness: Brightness.dark
        ),
        home: FutureBuilder(
            future: _repository.getCurrentUser(),
            builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
              if (snapshot.hasData) {
                return HomeScreen();
              }
              else {
                return LoginScreen();
              }
            }
        ),
      ),
    );
  }
}


