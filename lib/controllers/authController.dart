import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_connect/controllers/firebase_repo.dart';
import 'package:ds_connect/ui/home/Login.dart';
import 'package:ds_connect/ui/profile/profile__page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebaseStorage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  var test;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> firebaseUser = Rxn<User>();
BuildContext context;
RxInt phoneNumberEntered=RxInt(0);
RxnString verificationCode=RxnString();
  RxnInt resendCode=RxnInt();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController(text:"");
  final TextEditingController userNameController = TextEditingController();

Rx<FirebaseFirestore> document;
  RxBool resendOtp=RxBool(false);
  String get user => firebaseUser.value?.phoneNumber;
  RxString userNameSetter=RxString("");
  RxString profileNameSetter=RxString("");
  RxString phoneNumber=RxString("");
  RxString descriptionSetter=RxString("");
  RxString tweet=RxString("");
  bool userNameExistence = false;
  bool phoneNumberExistence=false;
  bool existence=false;
  int currentScreen=0;
  RxBool invalidName=RxBool(true),invalidUserName=RxBool(true),invalidPhoneNumber=RxBool(true);
  ImagePicker picker=ImagePicker();
RxString profilePic;
RxBool codeSent=RxBool(false);
RxInt resetTimer=RxInt(30);
RxBool safeExit=RxBool(false);
  @override
  onInit() async{
    firebaseUser.bindStream(_auth.authStateChanges());

    if(firebaseUser.value!=null)
    await FirebaseFirestore.instance.collection("accounts").doc(firebaseUser.value.phoneNumber.substring(3)).get().then((value) {
      profilePic=value.exists?RxString(value['profilePic']):RxString("https://upload.wikimedia.org/wikipedia/commons/6/60/Facebook_default_female_avatar.gif");

    print("${profilePic.value}");
    });
else
  profilePic=RxString("");

    super.onInit();
  }

  void createUser(String name, String email, String password) async {
    try {
       await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      //create user in database.dart


    } catch (e) {

      showDialog(context: context, builder: (context)
      {

        return errorDialog("error creating email",e.message);
      });
    }
  }

  AlertDialog errorDialog(String errorMessage,String details) {
    return AlertDialog(title: Text(errorMessage),content: Text(details),actions: [TextButton(onPressed: ()
        {
          Get.back();
        },child: Text("Ok",style: TextStyle(color: Color.fromRGBO(29,0,184, 1),fontFamily: "Acme"),),)],);
  }

  void login(String email, String password,BuildContext context) async {
    try {
     await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);

    } catch (e) {
      String message=e.message;
      RegExp emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if(!emailValid.hasMatch(email)||password.length<6)
        message="Enter Valid Credentials";
      showDialog(context: context, builder: (context)
      {
        return errorDialog("Error Logging in",message);
      });
    }
  }

  void signOut() async {
    currentScreen=0;
    try {
      await _auth.signOut();
      Get.offAll(Login());
    } catch (e) {
      showDialog(context: context, builder: (context)
      {
        return errorDialog("error Signing Out",e.message);
      });
    }
  }
  verifyPhone(String phone) async {
    FirebaseRepo firebaseRepo=Get.find<FirebaseRepo>();
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phone',
       // forceResendingToken: resendCode.value,
        verificationCompleted: (PhoneAuthCredential credential) async {
          if(safeExit.value!=true)
            { await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {
              if (value.user != null) {
                phoneNumberEntered.value=0;
                firebaseUser.value=FirebaseAuth.instance.currentUser;
              }
            });
            if(currentScreen==2)
            {FirebaseFirestore.instance.collection("accounts").doc(phoneController.text).set({
              "name":nameController.text,
              "userName":userNameController.text,
              "phoneNumber":phoneController.text,
              "profilePic":"https://upload.wikimedia.org/wikipedia/commons/6/60/Facebook_default_female_avatar.gif",
              "description":"Hello everyone! I am New to DsConnect. Looking Forward to connect with you people"
            });

            }
            firebaseRepo.updatePic();
            firebaseRepo.initialDetails();
            invalidName.value=true;
            invalidPhoneNumber.value=true;
            invalidUserName.value=true;
            profileNameSetter.value="";
            userNameSetter.value="";
            phoneNumber.value="";
            Get.off(()=>ProPage());
            phoneNumberEntered.value = 0;
            safeExit.value=false;

            }



        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("\n${e.code}")));
        },
        codeSent: (String verificationID, int resendToken) {
            verificationCode.value = verificationID;
codeSent.value=true;

            Timer.periodic(Duration(seconds: 1), (timer) {
              resetTimer.value--;
              if(resetTimer.value==0)
                {
                  resetTimer.value=30;
                  codeSent.value=false;
                  timer.cancel();
                }
                });

        },
        codeAutoRetrievalTimeout: (String verificationID,[int forcedResendingToken]) {
            verificationCode.value = verificationID;
            //resendCode.value=forcedResendingToken;
            codeSent.value=false;
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Resending OTP")));
        },timeout: Duration(seconds: 30));
    //     timeout: Duration(seconds: 60)).then((value)
    // {
    //   resendOtp.value=true;
    // });
  }

  uploadProfilePic(File file)
  async {
    try
    {
      var user=firebaseUser.value;
      var storageRef=firebaseStorage.FirebaseStorage.instance.ref().child("user/profile/${user.uid}");
      firebaseStorage.UploadTask uploadTask=storageRef.putFile(file);
      firebaseStorage.TaskSnapshot taskSnapshotStorage=await uploadTask.whenComplete(() => null);
      await taskSnapshotStorage.ref.getDownloadURL().then((value) {
profilePic.value=value;

FirebaseFirestore.instance.collection("accounts").doc(firebaseUser.value.phoneNumber.substring(3)).update({"profilePic":profilePic.value});

      });

    }
    catch(e)
    {
      showDialog(context: context, builder: (context)=>AlertDialog(content: Text("${e.message}"),actions: [TextButton(onPressed: ()=>Get.back(), child: Text("Ok"))],));
      print(profilePic.value);
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${profilePic.value}")));

  }

}