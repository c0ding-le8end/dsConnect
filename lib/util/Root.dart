import 'package:ds_connect/controllers/authController.dart';
import 'package:ds_connect/ui/home/Login.dart';
import 'package:ds_connect/ui/profile/profile__page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends GetWidget<AuthController>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx((){
      return Get.find<AuthController>().user !=null? ProPage():Login();
    });
    throw UnimplementedError();
  }

}