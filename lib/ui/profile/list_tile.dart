import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:ds_connect/controllers/authController.dart';
import 'package:ds_connect/controllers/firebase_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TweetTile extends StatelessWidget {
  final AuthController controller=Get.find<AuthController>();
  final FirebaseRepo firebaseRepo=Get.find<FirebaseRepo>();
  final String tweet;
   TweetTile({Key key, this.tweet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
          child: Card(elevation: 10,
            child: Container(

              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                   border: Border.all(color: Colors.grey.shade300)),
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 15.0, right: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(children: [CircularProfileAvatar(controller.profilePic.value, imageFit: BoxFit.cover,
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
                    )],),

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
