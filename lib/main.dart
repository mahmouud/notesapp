import 'package:flutter/material.dart';
import 'package:notesapp/app/auth/login.dart';
import 'package:notesapp/app/auth/singnup.dart';
import 'package:notesapp/app/home.dart';
import 'package:notesapp/app/nots/addnots.dart';
import 'package:notesapp/app/nots/editnote.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/componant/test.dart';
import 'app/componant/test2.dart';

late SharedPreferences sharpref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharpref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      initialRoute: sharpref.getString("key") == null ? "Login" : "Home",
      routes: {
        "Login": (context) => const Login(),
        "signup": (context) => const SignUP(),
        "Home": (context) => const Home(),
        "test": (context) => const test(),
        "testing": (context) => const testing(),
        "addnote": (context) => const addnote(),
        "editnots": (context) => const editnots(),
      },
    );
  }
}
