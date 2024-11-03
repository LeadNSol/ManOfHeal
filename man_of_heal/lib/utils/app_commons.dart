import 'package:get/get.dart';
import 'package:man_of_heal/controllers/auth_controller.dart';

import '../models/user_model.dart';

class AppCommons {
  AppCommons._();

  // static AuthController get authController {
  //   try{
  //     return Get.find();
  //   }catch(e){
  //     Get.lazyPut(()=>AuthController());
  //     return Get.find() ?? Get.put(AuthController(), permanent: true);
  //   }
  // }

  static AuthController authController = Get.put(AuthController(), permanent: true);



  static bool isAdmin = authController.admin.value;

  static UserModel? get userModel {

    return authController.userModel!;
  }
}
