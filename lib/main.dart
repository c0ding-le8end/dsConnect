import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_connect/bindings/authBindings.dart';

import 'package:ds_connect/ui/home/Login.dart';
import 'package:ds_connect/ui/profile/list_tile.dart';
import 'package:ds_connect/ui/profile/profile__page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'util/Root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');

  runApp(GetMaterialApp(initialBinding:AuthBinding(),home: Root(),));
}



