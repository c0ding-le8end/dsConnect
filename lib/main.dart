import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_connect/login_screen_2.dart';
import 'package:ds_connect/student_network.dart';
import 'package:ds_connect/student_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home:LoginScreen2() ,));
}



class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var userStream;
  @override
  void initState() {
   userStream = FirebaseFirestore.instance
        .collection("test")
        .doc("rQghcC8F8CYSQae9MnQ4")
        .snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Center(child: Container(child: StreamBuilder<DocumentSnapshot>(
          stream: userStream,
          builder: (context, snapshot) {
            return Container(child: Text(snapshot.data['name']));
          }
      ),),),
    );
  }
}
