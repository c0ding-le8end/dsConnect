import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_connect/ui/Home.dart';
import 'package:ds_connect/ui/faculty_login.dart';
import 'package:ds_connect/ui/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home:Welcome() , routes: <String, WidgetBuilder>{
    "Login": (BuildContext context) => Login(),
    "Welcome": (BuildContext context) => Welcome(),
    "MainScreen": (BuildContext context) => MyApp(),
  },));
}



