import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';

class AppInitBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LandingPageController(), permanent: true);
    Get.put(AuthController(), permanent: true);

    Get.put(CategoryController());
  }
}
