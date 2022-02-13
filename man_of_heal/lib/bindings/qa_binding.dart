import 'package:get/get.dart';
import 'package:man_of_heal/controllers/qa_controller.dart';

class QABinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => QAController());
  }

}
