import 'package:ds_connect/controllers/authController.dart';
import 'package:ds_connect/controllers/firebase_repo.dart';
import 'package:get/get.dart';


class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<FirebaseRepo>(FirebaseRepo(),permanent: true);
  }
}