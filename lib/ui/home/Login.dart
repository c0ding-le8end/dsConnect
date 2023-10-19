
import 'package:ds_connect/controllers/authController.dart';
// import 'package:ds_connect/ui/home/otp_screen.dart';
import 'package:ds_connect/ui/home/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../model/animations.dart';





class Login extends GetWidget<AuthController>{
  final Color backgroundColor1 = const Color(0xFF444152);
  final Color backgroundColor2 = const Color(0xFF6f6c7d);
  final Color highlightColor = const Color(0xfff65aa3);
  final Color foregroundColor = Colors.white;
 // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();






  @override
  Widget build(BuildContext context) {
    controller.context=context;
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(height:MediaQuery.of(context).size.height,width:MediaQuery.of(context).size.width,decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/login.png'),
                  fit: BoxFit.fill
              )
          ),
            child: Obx(()
            {
              if(controller.signUpPageSelected.value==0)
                {
                return SingleChildScrollView(
                  child: Column(
                  children: <Widget>[
                  Container(
                  height: 400,
                  
                  child: Padding(
                    padding: const EdgeInsets.only(top:100.0),
                    child: FadeAnimation(0.6, Container(
                    margin: EdgeInsets.only(top: 50),
                                child: Center(
                                child: Text("DsConnect", style: TextStyle(fontFamily:"Acme",color: Color.fromRGBO(29,0,184, 1), fontSize: 40, fontWeight: FontWeight.bold),),
                                ),
                                )),
                  ),
                                ),
                                Padding(
                                padding: EdgeInsets.all(30.0),
                                child: Column(
                                children: <Widget>[
                                FadeAnimation(0.8, Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                              BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10)
                              )
                              ]
                              ),
                              child:
                              Container(padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey[100]!))
                              ),
                              child: Form(
                                key: _formKey,
                                child: Column(
                  children: <Widget>[
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  
                    // ignore: deprecated_member_use
                  ],
                                ),
                              ),
                  
                  
                              //   TextFormField(controller: controller.phoneController,cursorColor: Colors.black87,
                              //   // ignore: missing_return
                              //   textAlign: TextAlign.center,
                              //   keyboardType: TextInputType.phone,
                              //   maxLength: 10,
                              //   decoration: InputDecoration(
                              //     counterText: "",
                              //   border: InputBorder.none,
                              //   hintText: "Phone No ",
                              //   hintStyle: TextStyle(color: Colors.grey[400]),
                              // //hintStyle: TextStyle(color: this.foregroundColor),
                              //
                              // ),
                              //
                              // ),
                              )
                  
                              )),
                              SizedBox(height: 30,),
                              FadeAnimation(1, InkWell(
                              onTap: controller.codeSent.value==false?() async
                              {try{
                               controller.login(controller.emailController.text, controller.passwordController.text, context);
                  
                              }
                               on FirebaseAuthException catch(e)
                               {
                                 return showDialog(context: context, builder: (context)
                                 {
                   return SimpleDialog(children:[e.message.toString()=="a document path must be a non-empty string"?Padding(
                     padding: const EdgeInsets.only(top:20),
                     child: Container(child: Center(child: Text("Enter a valid  email first",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,fontFamily: "OpenSans"),))),
                   ):Text("${e.message}"),TextButton(child: Text("Ok",style: TextStyle(color: Color.fromRGBO(29,0,184, 1),fontFamily: "Acme"),),onPressed: ()=>Get.back(),)]  ,);
                                 });
                               }
                  
                              }:()=>null,
                              child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                              colors: [
                              Color.fromRGBO(29,0,184 ,1),
                              Color.fromRGBO(29,0,184, 0.6),//150,94,234
                              ]
                              )
                              ),
                              child: Center(
                              child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                              ),
                              ),
                              )),
                  
                              SizedBox(height: 70,),
                              FadeAnimation(0.5, InkWell(onTap: ()
                              {
                              controller.signUpPageSelected.value=1;
                              },child: Text("Create a New Account", style: TextStyle(color: Color.fromRGBO(29,0,184, 1),fontWeight:FontWeight.bold,fontFamily: "OpenSans",fontSize: 18),))),
                              ],
                              ),
                              )
                              ],
                                ),
                );}

else
  {
    print("signup resetting here");
    return SignUp();
  }
            })
          ),
        )
    );
  }

}



//things to add later






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



// Row(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// Padding(
// padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
// child: Icon(
// Icons.phone,
// color: Colors.grey,
// ),
// ),
// Expanded(
// child: Container(padding: EdgeInsets.all(8.0),
// decoration: BoxDecoration(
// border: Border(bottom: BorderSide(color: Colors.grey[100]))
// ),
// child: Form(
// key: _formKey,
// child: Column(
// children: <Widget>[
// Row(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// Padding(
// padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
// child: Icon(
// Icons.alternate_email,
// color: Colors.grey,
// ),
// ),
// Expanded(
// child: Container(padding: EdgeInsets.all(8.0),
// decoration: BoxDecoration(
// border: Border(bottom: BorderSide(color: Colors.grey[100]))
// ),
// child: TextFormField(controller: controller.emailController,cursorColor: Colors.black87,
// // ignore: missing_return
// textAlign: TextAlign.center,
// decoration: InputDecoration(
// border: InputBorder.none,
// hintText: "Email ",
// hintStyle: TextStyle(color: Colors.grey[400]),
// //hintStyle: TextStyle(color: this.foregroundColor),
//
// ),
//
// ),
// ),
// ),
// ],
// ),
// Row(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// Padding(
// padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
// child: Icon(
// Icons.lock_open,
// color: Colors.grey,
//
// ),
// ),
// Expanded(
// child: Container(decoration: BoxDecoration(
// border: Border(bottom: BorderSide(color: Colors.grey[100]))
// ),
// child: TextFormField(controller: passwordController,
// obscureText: true,
// textAlign: TextAlign.center,
// decoration: InputDecoration(
// border: InputBorder.none,
// hintText: 'Password',
// hintStyle: TextStyle(color: Colors.grey[400]),
//
// ),
//
// ),
// ),
// ),
// ],
// ),
//
// // ignore: deprecated_member_use
// ],
// ),
// ),
//
//
// //   TextFormField(controller: controller.phoneController,cursorColor: Colors.black87,
// //   // ignore: missing_return
// //   textAlign: TextAlign.center,
// //   keyboardType: TextInputType.phone,
// //   maxLength: 10,
// //   decoration: InputDecoration(
// //     counterText: "",
// //   border: InputBorder.none,
// //   hintText: "Phone No ",
// //   hintStyle: TextStyle(color: Colors.grey[400]),
// // //hintStyle: TextStyle(color: this.foregroundColor),
// //
// // ),
// //
// // ),
// ),
// ),
// ],
// )

//phone authentication
// onTap: controller.codeSent.value==false?() async
//             {try{
//               await FirebaseFirestore.instance.collection("accounts").doc(controller.phoneController.text).get().then((value) {
//                 controller.existence= value.exists;
//
//               });
//               if(!controller.existence)
//                 return showDialog(context: context, builder: (context)
//                 {
//                   return SimpleDialog(children:[Padding(
//                     padding: const EdgeInsets.only(top:20,left: 20),
//                     child: Container(child: Center(child: Text("The number you have entered is either invalid or does not exist",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,fontFamily: "OpenSans"),))),
//                   ),TextButton(child: Text("Ok",style: TextStyle(color: Color.fromRGBO(29,0,184, 1),fontFamily: "Acme"),),onPressed: ()=>Get.back(),)]  ,);
//                 });
//               //
//               else
//                 {
//                   controller.currentScreen=controller.phoneNumberEntered.value;
//                   controller.phoneNumberEntered.value=1;
//                 }
//
//             }
//              catch(e)
//              {
//                return showDialog(context: context, builder: (context)
//                {
//                  return SimpleDialog(children:[e.message=="a document path must be a non-empty string"?Padding(
//                    padding: const EdgeInsets.only(top:20),
//                    child: Container(child: Center(child: Text("Enter a phone number first",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,fontFamily: "OpenSans"),))),
//                  ):Text("${e.message}"),TextButton(child: Text("Ok",style: TextStyle(color: Color.fromRGBO(29,0,184, 1),fontFamily: "Acme"),),onPressed: ()=>Get.back(),)]  ,);
//                });
//              }
//
//             }:()=>null,
// Obx(()=>controller.codeSent.value==false?Text("Send otp", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
// ):Text("Please Wait for ${controller.resetTimer.value} secs more",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),

//else
// if(controller.phoneNumberEntered.value==1)
//             {controller.verifyPhone(controller.phoneController.text);
//
//            // ignore: missing_return
//            return OtpScreen(context).buildOtpScreen();
//             }