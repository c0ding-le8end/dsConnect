import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_connect/controllers/authController.dart';
import 'package:ds_connect/controllers/firebase_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TweetTile extends StatelessWidget {
  final AuthController controller=Get.find<AuthController>();
  final FirebaseRepo firebaseRepo=Get.find<FirebaseRepo>();
  final String? tweet;
  final int? index;
   TweetTile({Key? key, this.tweet,this.index,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
          child: Card(elevation: 10,
            child: Container(

              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                   color: Colors.white,
                   border: Border.all(color: Colors.grey.shade300)),
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 15.0, right: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Row(children: [CircularProfileAvatar(controller.profilePic!.value, imageFit: BoxFit.cover,
                      //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                      radius: 35,
                      // sets radius, default 50.0
                      backgroundColor: Colors.transparent,
                      // sets background color, default Colors.white
                      borderWidth: 5,
                      // sets border, default 0.0// sets initials text, set your own style, default Text('')
                      borderColor: Colors.transparent.withOpacity(0.1),
                      // sets border color, default Colors.white
                      elevation: 5.0,showInitialTextAbovePicture:
                      true, ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Obx(
                            ()=> Text(
                          firebaseRepo.name.value,
                          style: TextStyle(
                              fontSize: 18,
fontFamily: "Acme",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                        Obx(
                            ()=> Text("@${firebaseRepo.userName.value}",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Acme",
                                color: Colors.grey.shade600,

                              )),
                        ),],),
                    ),Spacer(), PopupMenuButton(itemBuilder: (context)
                      {
                        return [PopupMenuItem(child: Text("Edit"),onTap: ()
                          {
                            Future.delayed(Duration(seconds: 1),()
                            {
                              showDialog(context: context, builder: (context)
                              {String tweetSetter=tweet!;
                              return SafeArea(
                                child: SimpleDialog(
                                  children: [Align(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.black45,
                                    ),
                                    onPressed: () {
                                      tweetSetter=tweet!;
                                      Get.back();
                                    },
                                  ),
                                  alignment: Alignment.topRight,
                                ),Card(
                                  elevation: 5,
                                  child: TextFormField(
                                    initialValue:tweetSetter,
                                    onChanged: (value) {
                                      tweetSetter = value;
                                    },
                                    // ignore: missing_return
                                    textAlign: TextAlign.left,
                                    keyboardType:
                                    TextInputType.multiline,
                                
                                    maxLines: 3,
                                    maxLength: 256,
                                
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color:
                                          Colors.grey[400]),
                                      //hintStyle: TextStyle(color: this.foregroundColor),
                                    ),
                                  ),
                                ),
                                  TextButton(
                                    onPressed: () {
                                      if (tweetSetter !="") {
                                        var reverseList=firebaseRepo.tweetList.reversed.toList();
                                        reverseList[index!]=tweetSetter;
                                        reverseList= reverseList.reversed.toList();
                                        firebaseRepo.tweetList.value=reverseList;
                                        FirebaseFirestore.instance
                                            .collection("accounts")
                                            .doc(FirebaseAuth.instance.currentUser!.uid).update({
                                          "tweetList":firebaseRepo.tweetList}).then((value) {
                                          reverseList=firebaseRepo.tweetList;
                                        });
                                        Get.back();
                                
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
                                            "Update Tweet",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold),
                                          )),
                                    ),
                                  )],),
                              );
                              });
                            });
                          },),PopupMenuItem(child: Text("Delete"),onTap: ()
                          {var reverseList=firebaseRepo.tweetList.reversed.toList();
                            reverseList.removeAt(index!);
                           reverseList= reverseList.reversed.toList();
                            firebaseRepo.tweetList.value=reverseList;
                            FirebaseFirestore.instance
                              .collection("accounts")
                              .doc(FirebaseAuth.instance.currentUser!.uid).update({
                          "tweetList":firebaseRepo.tweetList});
                            print("deleted");
                          },)];
                      },),],),

                    Divider(
                      color: Colors.blueGrey.shade900,
                    ),
                    Text(
                      "$tweet",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w300,
                          color: Colors.black87),
                    ),
                    Divider(
                      color: Colors.blueGrey.shade900,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}
