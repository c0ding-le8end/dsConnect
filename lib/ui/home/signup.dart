import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_connect/controllers/authController.dart';
import 'package:ds_connect/controllers/firebase_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

import '../../model/animations.dart';

class SignUp extends GetWidget<AuthController> {
  final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=,\.;]+$');


  final FirebaseRepo firebaseRepo=Get.find<FirebaseRepo>();

  final  validNumbers=RegExp(r'^[0-9]+$');
  final emptyName=RegExp(r'^[ ]+$');
  final invalidStyle = TextStyle(fontFamily: "OpenSans",color: Color(0xffFF9494),fontWeight: FontWeight.bold);
  RegExp validEmailExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async{
        controller.safeExit.value=true;
        controller.signUpPageSelected.value = 0;
        // controller.currentScreen=0;
        // controller.phoneNumberExistence=false;
        // controller.phoneNumberExistence=false;
        // controller.phoneController.clear();
        // controller.phoneNumber.value="";
        controller.nameController.clear();
        controller.profileNameSetter.value="";
        controller.userNameController.clear();
        controller.userNameSetter.value="";
        controller.invalidName.value=true;
        // controller.invalidPhoneNumber.value=true;
        controller.invalidUserName.value=true;
return false;
      },
      child: FadeAnimation(
        0.5,
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ]),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, bottom: 10.0, right: 00.0),
                              child: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]!))),
                                child: TextFormField(
                                  controller: controller.nameController,
                                  cursorColor: Colors.black87,
                                  onChanged: (value) {
                                    controller.profileNameSetter.value = value;

                                  },
                                  // ignore: missing_return
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.name,
                                  maxLength: 15,

                                  decoration: InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintText: "Name ",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400]),
                                    //hintStyle: TextStyle(color: this.foregroundColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        GetX<AuthController>(
                          builder: (controller) {
                            if (controller.profileNameSetter.value == ""||emptyName.hasMatch(controller.profileNameSetter.value)) {
                              controller.invalidName.value=true;
                              return Container();
                            }
                            controller.invalidName.value=false;
                            return Container();
                          },
                        )
                      ],
                    )

                    ),

                SizedBox(
                  height: 40,
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ]),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, bottom: 10.0, right: 00.0),
                              child: Icon(
                                Icons.people,
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]!))),
                                child: TextFormField(
                                  controller: controller.userNameController,
                                  cursorColor: Colors.black87,
                                  // ignore: missing_return
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.name,
                                  onChanged: (value) {
                                    controller.userNameSetter.value = value;
                                  },
                                  maxLength: 15,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintText: "User Name",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400]),
                                    //hintStyle: TextStyle(color: this.foregroundColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        GetX<AuthController>(
                          builder: (controller) {
                            if (controller.userNameSetter.value == "") {
                              controller.userNameExistence = false;
                              controller.invalidUserName.value=true;
                              return Container();
                            }

                            if (!validCharacters
                                .hasMatch(controller.userNameSetter.value)) {
                              controller.userNameExistence = false;
                              controller.invalidUserName.value=true;
                              debugPrint(
                                  "${validCharacters.hasMatch(controller.userNameSetter.value)}");
                              return Text(
                                  "UserName cannot have special characters",style: invalidStyle,);
                            }
                            firebaseRepo.queryCollection!.forEach((element) {
                              if (element['userName'] ==
                                  controller.userNameSetter.value)
                                controller.userNameExistence = true;
                            });
                            // debugPrint("$controller.userNameExistence");
                            if (controller.userNameExistence)
                              {controller.userNameExistence=false;
                              controller.invalidUserName.value=true;

                                return Text(
                                    "User Name Exists,try a different one",style: invalidStyle,);
                              }

                            controller.userNameExistence = false;
                            controller.invalidUserName.value=false;
                            return Container();
                          },
                        )
                      ],
                    )

                    ),
                SizedBox(
                  height: 40,
                ),
                Container(padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            blurRadius: 20.0,
                            offset: Offset(0, 10))
                      ]),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                            child: Icon(
                              Icons.alternate_email,
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: Container(padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[100]!))
                              ),
                              child: TextFormField(controller: controller.emailController,cursorColor: Colors.black87,
                                // ignore: missing_return
                                textAlign: TextAlign.center,
                                onChanged: (value)
                                {
                                  controller.email.value=value;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email ",
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  //hintStyle: TextStyle(color: this.foregroundColor),

                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                      GetX<AuthController>(
                        builder: (controller) {
                          if (controller.email.value == "") {
                            controller.emailExistence = false;
                            controller.invalidEmail.value=true;
                            return Container();
                          }

                          if (!validEmailExp
                              .hasMatch(controller.email.value)) {
                            controller.emailExistence = false;
                            controller.invalidEmail.value=true;

                            // debugPrint(
                            //     "${validCharacters.hasMatch(controller.userNameSetter.value)}");
                            return Text(
                              "Email Entered seems to be invalid",style: invalidStyle,);
                          }

                          for(var element in firebaseRepo.queryCollection!)
                            {
                              if (element['email'] ==
                                  controller.email.value)
                                controller.emailExistence = true;
                            }
                          // debugPrint("$controller.phoneNumberExistence");
                          if (controller.emailExistence)
                          {controller.emailExistence=false;
                          controller.invalidEmail.value=true;
                          return Text(
                            "An account for the given email already exists,try a different one",style: invalidStyle,);
                          }

                          controller.emailExistence = false;
                          controller.invalidEmail.value=false;
                          return Container();
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            blurRadius: 20.0,
                            offset: Offset(0, 10))
                      ]),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                            child: Icon(
                              Icons.lock_open,
                              color: Colors.grey,

                            ),
                          ),
                          Expanded(
                            child: Container(decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[100]!))
                            ),
                              child: TextFormField(controller: controller.passwordController,
                                obscureText: true,
                                onChanged: (value)
                                {
                                  controller.password.value=value;
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.grey[400]),

                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                      GetX<AuthController>(
                        builder: (controller) {
                          if (controller.password.value == "") {
                            controller.invalidPassword.value=true;
                            return Container();
                          }

                          if (controller.password.value.length<7||controller.password.value.length>14) {
                            controller.invalidPassword.value=true;

                            // debugPrint(
                            //     "${validCharacters.hasMatch(controller.userNameSetter.value)}");
                            return Text(
                              "Password must contain a minimum of 7 characters and a maximum of 14 characters",style: invalidStyle,);
                          }





                          controller.invalidPassword.value=false;
                          return Container();
                        },
                      )

                    ],
                  ),
                ),
//                 Container(
//                     padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Color.fromRGBO(143, 148, 251, .2),
//                               blurRadius: 20.0,
//                               offset: Offset(0, 10))
//                         ]),
//                     child: Column(
//                       children: [
//
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   top: 10.0, bottom: 10.0, right: 00.0),
//                               child: Icon(
//                                 Icons.phone,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             Expanded(
//                               child: Container(
//                                 padding: EdgeInsets.all(8.0),
//                                 decoration: BoxDecoration(
//                                     border: Border(
//                                         bottom:
//                                             BorderSide(color: Colors.grey[100]))),
//                                 child: TextFormField(
//                                   controller: controller.phoneController,
//                                   cursorColor: Colors.black87,
//                                   // ignore: missing_return
//                                   textAlign: TextAlign.center,
//                                   keyboardType: TextInputType.phone,
//                                   maxLength: 10,
// onChanged: (value)
//                                   {
//                                     controller.phoneNumber.value=value;
//                                   },
//                                   decoration: InputDecoration(
//                                     counterText: "",
//                                     border: InputBorder.none,
//                                     hintText: "Phone No ",
//                                     hintStyle: TextStyle(color: Colors.grey[400]),
//                                     //hintStyle: TextStyle(color: this.foregroundColor),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),GetX<AuthController>(
//                           builder: (controller) {
//                             if (controller.phoneNumber.value == "") {
//                               controller.phoneNumberExistence = false;
//                               controller.invalidPhoneNumber.value=true;
//                               return Container();
//                             }
//
//                             if (!validNumbers
//                                 .hasMatch(controller.phoneNumber.value)) {
//                               controller.phoneNumberExistence = false;
//                               controller.invalidPhoneNumber.value=true;
//
//                               debugPrint(
//                                   "${validCharacters.hasMatch(controller.userNameSetter.value)}");
//                               return Text(
//                                   "PhoneNumber cannot have special characters",style: invalidStyle,);
//                             }
//
//                             firebaseRepo.queryCollection.forEach((element) {
//                               if (element['phoneNumber'] ==
//                                   controller.phoneNumber.value)
//                                 controller.phoneNumberExistence = true;
//                             });
//                             // debugPrint("$controller.phoneNumberExistence");
//                             if (controller.phoneNumberExistence)
//                             {controller.phoneNumberExistence=false;
//                             controller.invalidPhoneNumber.value=true;
//                             return Text(
//                                 "Phone Number Exists,try a different one",style: invalidStyle,);
//                             }
//
//                             controller.phoneNumberExistence = false;
//                             controller.invalidPhoneNumber.value=false;
//                             return Container();
//                           },
//                         )
//                       ],
//                     )
//
//                     ),
                SizedBox(height: 40),
                GetBuilder<AuthController>(
                  builder:(controller)=> Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(29, 0, 184, 1),
                          Color.fromRGBO(29, 0, 184, 0.6), //150,94,234
                        ])),
                    child: InkWell(
                      onTap: (() async {
                        try{
                          if(controller.invalidUserName.value==false&&controller.invalidEmail.value==false&&controller.invalidName.value==false&&controller.invalidPassword.value==false)
                            {

                            controller.context = context;
                            controller.createUser(controller.nameController.text, controller.emailController.text, controller.passwordController.text,controller.userNameController.text);
                            }
                          else
                            return null;

                        }
                        on FirebaseAuthException catch(e)
                        {
                          errorDialog(context, e.message.toString());
                        }


                      }),
                      child:  Center(
                        child: Text("Create Account", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> errorDialog(BuildContext context, String message) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("$message"),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () => Get.back(),
              )
            ],
          );
        });
  }
}


//changes to be made later

// Form(
//   key: _formKey,
//   child: Column(
//     children: <Widget>[

//
//       // ignore: deprecated_member_use
//     ],
//   ),
// ),







// TextFormField(
//   decoration: InputDecoration(hintText: "Full Name"),
//   controller: nameController,
// ),

// TextFormField(
//   decoration: InputDecoration(hintText: "Email"),
//   controller: emailController,
// ),


// Form(
//   key: _formKey,
//   child: Column(
//     children: <Widget>[
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
//             child: Icon(
//               Icons.alternate_email,
//               color: Colors.grey,
//             ),
//           ),
//           Expanded(
//             child: Container(padding: EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                   border: Border(bottom: BorderSide(color: Colors.grey[100]))
//               ),
//               child: TextFormField(controller: emailController,cursorColor: Colors.black87,
//                 // ignore: missing_return
//                 textAlign: TextAlign.center,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: "Email ",
//                   hintStyle: TextStyle(color: Colors.grey[400]),
//                   //hintStyle: TextStyle(color: this.foregroundColor),
//
//                 ),
//
//               ),
//             ),
//           ),
//         ],
//       ),
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
//             child: Icon(
//               Icons.lock_open,
//               color: Colors.grey,
//
//             ),
//           ),
//           Expanded(
//             child: Container(decoration: BoxDecoration(
//                 border: Border(bottom: BorderSide(color: Colors.grey[100]))
//             ),
//               child: TextFormField(controller: passwordController,
//                 obscureText: true,
//                 textAlign: TextAlign.center,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: 'Password',
//                   hintStyle: TextStyle(color: Colors.grey[400]),
//
//                 ),
//
//               ),
//             ),
//           ),
//         ],
//       ),
//
//       // ignore: deprecated_member_use
//     ],
//   ),
// ),


// Form(
//   key: _formKey,
//   child: Column(
//     children: <Widget>[
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
//             child: Icon(
//               Icons.alternate_email,
//               color: Colors.grey,
//             ),
//           ),
//           Expanded(
//             child: Container(padding: EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                   border: Border(bottom: BorderSide(color: Colors.grey[100]))
//               ),
//               child: TextFormField(controller: emailController,cursorColor: Colors.black87,
//                 // ignore: missing_return
//                 textAlign: TextAlign.center,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: "Email ",
//                   hintStyle: TextStyle(color: Colors.grey[400]),
//                   //hintStyle: TextStyle(color: this.foregroundColor),
//
//                 ),
//
//               ),
//             ),
//           ),
//         ],
//       ),
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
//             child: Icon(
//               Icons.lock_open,
//               color: Colors.grey,
//
//             ),
//           ),
//           Expanded(
//             child: Container(decoration: BoxDecoration(
//                 border: Border(bottom: BorderSide(color: Colors.grey[100]))
//             ),
//               child: TextFormField(controller: passwordController,
//                 obscureText: true,
//                 textAlign: TextAlign.center,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: 'Password',
//                   hintStyle: TextStyle(color: Colors.grey[400]),
//
//                 ),
//
//               ),
//             ),
//           ),
//         ],
//       ),
//
//       // ignore: deprecated_member_use
//     ],
//   ),
// ),




// controller.login(phoneController.text, passwordController.text);
// else
//   {
//     if(emailValidated==false&&passwordValidated==true)
//       errorMessage="Enter a Valid Email";
//     else
//     if(emailValidated==true&&passwordValidated==false)
//       errorMessage="Enter a Valid Password";
//     else
//       errorMessage="Enter a Valid Email and Password";
//     showDialog(context: context, builder: (context)
//     {
//       return AlertDialog(content: Text(errorMessage),actions: [TextButton(onPressed: ()
//         {
//           Get.back();
//         },child: Text("Ok"),)],);
//     });
//   }
//Obx(()=>controller.codeSent.value==false?Text("Create Account", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                         ):Text("Please Wait for ${controller.resetTimer.value} secs more",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
