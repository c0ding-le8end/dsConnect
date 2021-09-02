import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
User userDetails;
class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  Stream<DocumentSnapshot> userStream;
  bool isloggedin = false;
  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("Welcome");
      }
    });
  }
  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      var usn=firebaseUser.email.substring(0,10).toUpperCase();
      setState(() {
        this.user = firebaseUser;
        userDetails = firebaseUser;
        this.isloggedin = true;
        userStream = FirebaseFirestore.instance
            .collection("students")
            .doc(usn)
            .snapshots();
        if (userStream == null) {
          setState(() {
            userStream = FirebaseFirestore.instance
                .collection("users")
                .doc(firebaseUser.email)
                .snapshots();
          });
        }
      });
    }
  }
  @override
  void initState() {
    this.checkAuthentification();
    this.getUser();


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(actions: [IconButton(icon: Icon(Icons.email), onPressed: ()
    async{
      _auth.signOut();
    })],),
      body: Container(
        child: Center(child: Container(child: StreamBuilder<DocumentSnapshot>(
            stream: userStream,
            builder: (context, snapshot) {

             if(snapshot.hasData)
              return Container(child: Text(snapshot.data['name']));
             else return Container();
            }
        ),),),
      ),
    );
  }
}