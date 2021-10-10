import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_connect/model/animations.dart';
import 'package:ds_connect/controllers/authController.dart';
import 'package:ds_connect/controllers/firebase_repo.dart';
import 'package:ds_connect/ui/profile/profile__page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpScreen {
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),

  );
  final TextEditingController _pinPutController = TextEditingController();
final AuthController controller=Get.find<AuthController>();
BuildContext context;

  OtpScreen(this.context);

  buildOtpScreen()
{
return  WillPopScope(onWillPop: ()
  {controller.phoneNumberEntered.value=controller.currentScreen;//login:0,pinput:1,signup:2  l->p=0,1 p->0,0  s->p=2,0
  if(controller.currentScreen!=2)
  {
    controller.safeExit.value=true;
    controller.invalidName.value=true;
    controller.invalidUserName.value=true;
    controller.invalidPhoneNumber.value=true;
    controller.userName.value="";
    controller.phoneNumber.value="";
    controller.name.value="";
    controller.nameController.text="";
    controller.userNameController.clear();
    controller.phoneController.clear();

  }
  controller.currentScreen=0;
return null;

  },
    child: FadeAnimation
      (0.8,
      Padding(
        padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  'Verify +91-${controller.phoneController.text}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 26,fontFamily: "Acme",color: Color.fromRGBO(12,10,124, 1)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: PinPut(
                fieldsCount: 6,
                textStyle: const TextStyle(
                    fontSize: 25.0, color: Colors.white),
                eachFieldWidth: 40.0,
                eachFieldHeight: 55.0,
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: pinPutDecoration,
                selectedFieldDecoration: pinPutDecoration,
                followingFieldDecoration: pinPutDecoration,
                pinAnimationType: PinAnimationType.fade,
                onSubmit: (pin) async {
                  FirebaseRepo firebaseRepo=Get.find<FirebaseRepo>();
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(
                        PhoneAuthProvider.credential(
                            verificationId: controller.verificationCode
                                .value, smsCode: pin))
                        .then((value) async {
                      if (value.user != null) {

                        debugPrint("${controller.currentScreen}");

                        controller.firebaseUser.value=FirebaseAuth.instance.currentUser;
                        controller.firebaseUser.value.updateDisplayName("${controller.userNameController.value}");
                      }
                    });
                    if(controller.currentScreen==2)
                      FirebaseFirestore.instance.collection("accounts").doc(controller.phoneController.text).set({
                        "name":controller.nameController.text,
                        "userName":controller.userNameController.text,
                        "phoneNumber":controller.phoneController.text,
                        "profilePic":"https://upload.wikimedia.org/wikipedia/commons/6/60/Facebook_default_female_avatar.gif",
                        "description":"Hello everyone! I am New to DsConnect. Looking Forward to connect with you people"
                      });
                    firebaseRepo.updatePic();
                    firebaseRepo.initialDetails();
                    Get.off(()=>ProPage());
                    controller.phoneNumberEntered.value = 0;
                    controller.invalidName.value=true;
                    controller.invalidPhoneNumber.value=true;
                    controller.invalidUserName.value=true;
                    controller.name.value="";
                    controller.userName.value="";
                    controller.phoneNumber.value="";
                    controller.phoneController.clear();
                    controller.userNameController.text="";
                    controller.nameController.clear();

                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("${e.toString()}")));
                    // print("here");
                    // print("${e.message}");
                    // print("here");
                  }
                },
              ),
            ),
//  GetBuilder<AuthController>(builder:(controller)=> TextButton(onPressed: controller.resendOtp.value==true?(()=>controller.verifyPhone(controller.phoneController.text)):null, child: Text("Resend",style: TextStyle(color: controller.resendOtp.value==true?()=>Colors.green:Colors.red),)))
          ],
        ),
      ),
    ),
  );
}




}