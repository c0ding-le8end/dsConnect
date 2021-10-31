import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';

import 'package:ds_connect/model/animations.dart';
import 'package:ds_connect/controllers/authController.dart';
import 'package:ds_connect/controllers/firebase_repo.dart';
import 'package:ds_connect/ui/profile/edit_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'list_tile.dart';

class ProPage extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();
  final FirebaseRepo firebaseRepo = Get.find<FirebaseRepo>();
  final emptyName = RegExp(r'^[ ]+$');
  final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=,\.;]+$');
  final invalidStyle = TextStyle(
      fontFamily: "OpenSans", color: Colors.grey, fontWeight: FontWeight.bold);

  ProPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return WillPopScope(onWillPop: ()async
      {
        showDialog(context: context, builder: (context)
        {
          return AlertDialog(content: Text("SignOut?",style: TextStyle(fontFamily: "OpenSans",color: Color.fromRGBO(29,0,184, 1)),),
            actions: [TextButton(child: Text("cancel",style: TextStyle(fontWeight:FontWeight.bold,fontFamily: "Acme",color: Color.fromRGBO(29,0,184, 1))),onPressed: ()=>Get.back(),),TextButton(child: Text("Ok",style: TextStyle(fontWeight:FontWeight.bold,fontFamily: "Acme",color: Color.fromRGBO(29,0,184, 1))),onPressed: ()
            {
              controller.signOut();
              firebaseRepo.refreshDatabase();
            },)],);
        });
        return null;
      },
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
backgroundColor: Color(0xFFf8f9f5),
          floatingActionButton: FloatingActionButton(onPressed: ()
            {
              showDialog(context: context, builder: (context)
              {
                return SimpleDialog(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),children: [Align(
                  child: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black45,
                    ),
                    onPressed: () {
                      Get.back();
                      controller.tweet.value="";
                    },
                  ),
                  alignment: Alignment.topRight,
                ),Card(
                  elevation: 5,
                  child: TextFormField(
                    onChanged: (value) {
                      controller.tweet
                          .value = value;
                    },
                    // ignore: missing_return
                    textAlign: TextAlign.center,
                    keyboardType:
                    TextInputType.multiline,

                    maxLines: 3,
                    maxLength: 256,

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Write your tweet",
                      hintStyle: TextStyle(
                          color:
                          Colors.grey[400]),
                      //hintStyle: TextStyle(color: this.foregroundColor),
                    ),
                  ),
                ),
                  TextButton(
                    onPressed: () {
                      if (controller.tweet
                          .value !="") {
                        firebaseRepo.addTweet(
                            controller.tweet.value);
                        Get.back();
                        controller.tweet.value="";
                      } else
                        return null;
                    },
                    child: Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(
                                  50)),
                          gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(
                                    29, 0, 184, 1),
                                Color.fromRGBO(29,
                                    0, 184, 0.6),
                                //150,94,234
                              ])),
                      child: Center(
                          child: Text(
                            "Tweet",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight:
                                FontWeight.bold),
                          )),
                    ),
                  )],
                );
              });
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment(1.0, 0.0),
                    // 10% of the width, so there are ten blinds.
                    colors: [Color(0xFFffa69e), Color(0xFF861657)],
                    // whitish to gray
                    tileMode:
                        TileMode.repeated, // repeats the gradient over the canvas
                  )),
              child: Icon(FontAwesomeIcons.plus),
            ),
          ),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: FadeAnimation(
                1.8,
                Text(
                  "DsConnect",
                  style: TextStyle(
                      color: Colors.white, fontFamily: "Acme", fontSize: 30),
                )),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  showDialog(context: context, builder: (context)
                  {
                    return AlertDialog(content: Text("SignOut?",style: TextStyle(fontFamily: "OpenSans",color: Color.fromRGBO(29,0,184, 1)),),
                    actions: [TextButton(child: Text("cancel",style: TextStyle(fontWeight:FontWeight.bold,fontFamily: "Acme",color: Color.fromRGBO(29,0,184, 1))),onPressed: ()=>Get.back(),),TextButton(child: Text("Ok",style: TextStyle(fontWeight:FontWeight.bold,fontFamily: "Acme",color: Color.fromRGBO(29,0,184, 1))),onPressed: ()
                      {
                        controller.signOut();
                        firebaseRepo.refreshDatabase();
                      },)],);
                  });
                },
              )
            ],
          ),
          body: Obx(
            () => Stack(children: [
              Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      FadeAnimation(
                        1.8,
                        Container(
                          margin: EdgeInsets.only(bottom: 50),
                          height: MediaQuery.of(context).size.height / 3,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment(1.0, 0.0),
                            // 10% of the width, so there are ten blinds.
                            colors: [Color(0xFFffa69e), Color(0xFF861657)],
                            // whitish to gray
                            tileMode: TileMode
                                .repeated, // repeats the gradient over the canvas
                          )),
                        ),
                      ),
                      FadeAnimation(
                        2.4,
                        Container(
                          child: CircularProfileAvatar(
                            controller.profilePic.value, imageFit: BoxFit.cover,
                            //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                            radius: 50,
                            // sets radius, default 50.0
                            backgroundColor: Colors.transparent,
                            // sets background color, default Colors.white
                            borderWidth: 5,
                            // sets border, default 0.0// sets initials text, set your own style, default Text('')
                            borderColor: Color(0xFFffa69e).withOpacity(0.1),
                            // sets border color, default Colors.white
                            elevation: 5.0,
                            // sets elevation (shadow of the profile picture), default value is 0.0
                            //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                            // allow widget to cache image against provided url
                            onTap: () async {
                              controller.invalidUserName.value = false;
                              controller.invalidName.value = false;

                              controller.profileNameSetter.value = firebaseRepo.name.value;
                              controller.userNameSetter.value =
                                  firebaseRepo.userName.value;
                              controller.descriptionSetter.value =
                                  firebaseRepo.description.value;

                              showDialog(
                                  context: context,
                                  builder: (context) => EditProfile(context).edit());
                              // print(image.path==null?"not chosen":"${image.path}");
                            },
                            // sets on tap
                            showInitialTextAbovePicture:
                                true, // setting it true will show initials text above profile picture, default false
                          ),
                        ),
                      )
                    ],
                  ),
                  Obx(
                    () => FadeAnimation(
                        2.6,
                        Text(
                          firebaseRepo.name.value,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                              fontFamily: "Acme"),
                        )),
                  ),
                  Obx(
                    () => FadeAnimation(
                        2.6,
                        Text(
                          "@${firebaseRepo.userName.value}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black45,
                              fontFamily: "Acme"),
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Flexible(
                      child: FadeAnimation(
                          2.8,
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              firebaseRepo.description.value,
                              style: TextStyle(fontSize: 16, fontFamily: "Inter"),
                            ),
                          ))),
                ],
              ),
              DraggableScrollableSheet(
                builder: (context, scrollController) {
                  return FadeAnimation(
                    3.0,
                    Obx(
                      () {
                        var reversedList=firebaseRepo.tweetList.reversed.toList();
                        return Container(decoration: BoxDecoration(color: Color(0xFFFFFFFF),borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))),
                          child: GlowingOverscrollIndicator(color: Color(0xFF861657),axisDirection: AxisDirection.down,
                            child: ListView.separated(
                              controller: scrollController,
                              itemBuilder: (context, int index) {
                                return TweetTile(
                                    tweet: reversedList[index],index: index,);
                              },
                              separatorBuilder: (context, int index) {
                                return SizedBox(
                                  height: 20,
                                );
                              },
                              itemCount: reversedList.length,
                            ),
                          ),
                        );}
                    ),
                  );
                },
                initialChildSize: 0.4,
                minChildSize: 0.27,
                maxChildSize: 0.8,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
