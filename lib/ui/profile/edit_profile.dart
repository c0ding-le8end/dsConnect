import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:ds_connect/controllers/authController.dart';
import 'package:ds_connect/controllers/firebase_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile {
  final AuthController controller = Get.find<AuthController>();
  final FirebaseRepo firebaseRepo = Get.find<FirebaseRepo>();
  final emptyName = RegExp(r'^[ ]+$');
  final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=,\.;]+$');
  final invalidStyle = TextStyle(
      fontFamily: "OpenSans", color: Colors.grey, fontWeight: FontWeight.bold);
  BuildContext context;

  EditProfile(this.context);

  edit()  {
    controller.invalidUserName.value = false;
    controller.invalidName.value = false;

    controller.name.value = firebaseRepo.name.value;
    controller.userName.value =
        firebaseRepo.userName.value;
    controller.description.value =
        firebaseRepo.description.value;

   return SimpleDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      children: [
        Align(
          child: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black45,
            ),
            onPressed: () {
              Get.back();
              controller.userName.value = "";
              controller.invalidName.value =
              true;
              controller.invalidUserName.value =
              true;

              controller.name.value = "";
              controller.description.value = "";
            },
          ),
          alignment: Alignment.topRight,
        ),
        Obx(
              () =>
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 110),
                child: CircularProfileAvatar(
                  controller.profilePic.value,
                  imageFit: BoxFit.cover,
                  //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                  radius: 50,
                  // sets radius, default 50.0
                  backgroundColor:
                  Colors.transparent,
                  // sets background color, default Colors.white
                  borderWidth: 5,
                  // sets border, default 0.0// sets initials text, set your own style, default Text('')
                  borderColor: Color(0xFFffa69e)
                      .withOpacity(0.1),
                  // sets border color, default Colors.white
                  elevation: 5.0,
                  // sets elevation (shadow of the profile picture), default value is 0.0
                  //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                  // allow widget to cache image against provided url
                  onTap: () async {
                    try {
                      await controller.picker
                          .pickImage(
                          source: ImageSource
                              .gallery)
                          .then((value) {
                        value == null
                            ? print("null")
                            : print(value.path);
                        File file =
                        File(value.path);
                        controller
                            .uploadProfilePic(file);
                      });
                    } catch (e) {
                      print("cancelled");
                    }
                    // print(image.path==null?"not chosen":"${image.path}");
                  },
                  // sets on tap
                  showInitialTextAbovePicture:
                  true, // setting it true will show initials text above profile picture, default false
                ),
              ),
        ),
        Container(
          height: 300,
          width: MediaQuery
              .of(context)
              .size
              .width -
              150,
          child: GlowingOverscrollIndicator(color: Color(0xFF861657),axisDirection: AxisDirection.down,
            child: ListView(
              children: [
                SizedBox(
                  height: 75,
                ),
                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: <Widget>[
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                            right: 00.0),
                        child: Icon(
                          Icons.people,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding:
                        EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          child: TextFormField(
                            initialValue:
                            firebaseRepo
                                .userName
                                .value,
                            cursorColor:
                            Colors.black87,
                            // ignore: missing_return
                            textAlign:
                            TextAlign.center,
                            keyboardType:
                            TextInputType
                                .name,
                            onChanged: (value) {
                              controller.userName
                                  .value = value;
                              print("${controller.userName.value}");
                            },
                            maxLength: 15,
                            decoration:
                            InputDecoration(
                              counterText: "",
                              border: InputBorder
                                  .none,
                              hintText:
                              "User Name",
                              hintStyle: TextStyle(
                                  color: Colors
                                      .grey[400]),
                              //hintStyle: TextStyle(color: this.foregroundColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GetX<AuthController>(
                  builder: (controller) {
                    if (controller
                        .userName.value ==
                        "") {
                      controller
                          .userNameExistence =
                      false;
                      controller.invalidUserName
                          .value = true;
                      return Container();
                    }

                    if (!validCharacters.hasMatch(
                        controller
                            .userName.value)) {
                      controller
                          .userNameExistence =
                      false;
                      controller.invalidUserName
                          .value = true;
                      debugPrint(
                          "${validCharacters.hasMatch(
                              controller.userName.value)}");
                      return Text(
                        "UserName cannot have special characters",
                        style: invalidStyle,
                      );
                    }
                    controller.queryCollection
                        .forEach((element) {
                      if (element['userName'] ==
                          controller.userName
                              .value &&
                          element['userName'] !=
                              firebaseRepo
                                  .userName.value)
                        controller
                            .userNameExistence =
                        true;
                    });
                    // debugPrint("$controller.userNameExistence");
                    if (controller
                        .userNameExistence) {
                      controller
                          .userNameExistence =
                      false;
                      controller.invalidUserName
                          .value = true;

                      return Text(
                        "User Name Exists,try a different one",
                        style: invalidStyle,
                      );
                    }

                    controller.userNameExistence =
                    false;
                    controller.invalidUserName
                        .value = false;
                    return Container();
                  },
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(
                          10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(
                                143,
                                148,
                                251,
                                .2),
                            blurRadius: 20.0,
                            offset: Offset(0, 10))
                      ]),
                ),
                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: <Widget>[
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                            right: 00.0),
                        child: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding:
                        EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors
                                        .grey[
                                    100]))),
                        child: Card(
                          elevation: 5,
                          child: TextFormField(
                            initialValue:
                            firebaseRepo
                                .name.value,
                            cursorColor:
                            Colors.black87,
                            onChanged: (value) {
                              controller.name
                                  .value = value;
                            },
                            // ignore: missing_return
                            textAlign:
                            TextAlign.center,
                            keyboardType:
                            TextInputType
                                .name,
                            maxLength: 15,

                            decoration:
                            InputDecoration(
                              counterText: "",
                              border: InputBorder
                                  .none,
                              hintText: "Name ",
                              hintStyle: TextStyle(
                                  color: Colors
                                      .grey[400]),
                              //hintStyle: TextStyle(color: this.foregroundColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GetX<AuthController>(
                  builder: (controller) {
                    if (controller.name.value == ""||emptyName.hasMatch(controller.name.value)) {
                      controller.invalidName.value=true;
                      return Container();
                    }
                    controller.invalidName.value=false;
                    return Container();
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(
                          10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(
                                143,
                                148,
                                251,
                                .2),
                            blurRadius: 20.0,
                            offset: Offset(0, 10))
                      ]),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors
                                  .grey[100]))),
                  child: Card(
                    elevation: 5,
                    child: TextFormField(
                      initialValue: firebaseRepo
                          .description.value,
                      onChanged: (value) {
                        controller.description
                            .value = value;
                      },
                      // ignore: missing_return
                      textAlign: TextAlign.center,
                      keyboardType:
                      TextInputType.multiline,

                      maxLines: 5,
                      maxLength: 256,

                      decoration: InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                        hintText: "Descripiton",
                        hintStyle: TextStyle(
                            color:
                            Colors.grey[400]),
                        //hintStyle: TextStyle(color: this.foregroundColor),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (controller.invalidUserName
                        .value ==
                        false &&
                        controller.invalidName
                            .value ==
                            false) {
                      print("${controller.name.value}");
                      print("${controller.userName.value}");

                      firebaseRepo.updateDetails(
                          name: controller
                              .name.value,
                          description: controller
                              .description.value,
                          userName: controller
                              .userName.value);
                      Get.back();
                      controller.userName.value =
                      "";
                      controller.invalidName
                          .value = true;
                      controller.invalidUserName
                          .value = true;
                      controller.name.value = "";
                      controller
                          .description.value = "";
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
                          "Update",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight:
                              FontWeight.bold),
                        )),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

}