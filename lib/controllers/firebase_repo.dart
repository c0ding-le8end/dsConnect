import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_connect/controllers/authController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseRepo extends GetxController {
  AuthController authController = Get.find<AuthController>();
  RxString userName = RxString("User");
  RxString name = RxString("Name");
  RxString description = RxString("Hello everyone! I am New to DsConnect. Looking Forward to connect with you people");
  RxList tweetList=RxList();
  List<QueryDocumentSnapshot> queryCollection;
  @override
  void onInit() async {
    FirebaseFirestore.instance.collection("accounts").get().then((value) => queryCollection=value.docs);
    if (FirebaseAuth.instance.currentUser != null)
      await FirebaseFirestore.instance
          .collection("accounts")
          .doc(FirebaseAuth.instance.currentUser.phoneNumber.substring(3))
          .get()
          .then((value) {
        if (value.exists) {
          authController.profilePic.value = value['profilePic'];
          userName.value=value['userName'];
          name.value=value['name'];
          description.value=value['description'];
          tweetList.value=value['tweetList'];
        } else {
          authController.profilePic.value =
              "https://upload.wikimedia.org/wikipedia/commons/6/60/Facebook_default_female_avatar.gif";
        }
        print("${authController.profilePic.value}");
        print("${FirebaseAuth.instance.currentUser.phoneNumber.substring(3)}");
      });
    super.onInit();
  }

  updatePic() async {
    await FirebaseFirestore.instance
        .collection("accounts")
        .doc(FirebaseAuth.instance.currentUser.phoneNumber.substring(3))
        .get()
        .then((value) {
      value.exists
          ? authController.profilePic.value = value['profilePic']
          : authController.profilePic.value =
              "https://upload.wikimedia.org/wikipedia/commons/6/60/Facebook_default_female_avatar.gif";
    });
  }

  initialDetails() async{
    FirebaseFirestore.instance.collection("accounts").get().then((value) => queryCollection=value.docs);
    if (FirebaseAuth.instance.currentUser != null)
      await FirebaseFirestore.instance
        .collection("accounts")
        .doc(FirebaseAuth.instance.currentUser.phoneNumber.substring(3))
        .get()
        .then((value) {
      if (value.exists) {
        authController.profilePic.value = value['profilePic'];
        userName.value=value['userName'];
        name.value=value['name'];
        description.value=value['description'];
        tweetList.value=value['tweetList'];
      } else {
        authController.profilePic.value =
        "https://upload.wikimedia.org/wikipedia/commons/6/60/Facebook_default_female_avatar.gif";
      }
      print("${authController.profilePic.value}");
      print("${FirebaseAuth.instance.currentUser.phoneNumber.substring(3)}");
    });
  }
  updateDetails({String name,String description,String userName})
  async{
    FirebaseFirestore.instance.collection("accounts").get().then((value) => queryCollection=value.docs);
    await FirebaseFirestore.instance
        .collection("accounts")
        .doc(FirebaseAuth.instance.currentUser.phoneNumber.substring(3)).update({
      "name":name,
      "userName":userName,
      "description":description
    });
    initialDetails();
  }
  addTweet(String tweet)
  async{
    tweetList.add(tweet);
    await FirebaseFirestore.instance
        .collection("accounts")
        .doc(FirebaseAuth.instance.currentUser.phoneNumber.substring(3)).update({
      "tweetList":tweetList
    });


  }
  refreshDatabase()
  { FirebaseFirestore.instance.collection("accounts").get().then((value) => queryCollection=value.docs);
     userName = RxString("User");
     name = RxString("Name");
     description = RxString("Hello everyone! I am New to DsConnect. Looking Forward to connect with you people");
    tweetList=[].obs;
  }
}
