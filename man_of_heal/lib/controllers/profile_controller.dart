import 'package:get/get.dart';
import 'package:man_of_heal/controllers/export_controller.dart';
import 'package:man_of_heal/models/export_models.dart';

class ProfileController extends GetxController {
  final SubscriptionController? subscriptionController;
  final FeedBackController? feedBackController;

  ProfileController({this.subscriptionController, this.feedBackController});

  @override
  void onReady() {
    // TDO: implement onInit
    super.onReady();
  }

 // var subscriptionModel = Subscription().obs;

  Subscription? getSubsModel(){
    return subscriptionController?.subsFirebase;
  }

  int getSubscriptionExpiry(){
    return subscriptionController!.getSubscriptionExpiry();
  }

  double getAdminRating(){
    return feedBackController!.netAdminRating.value;
  }
  @override
  void onClose() {
    // TDO: implement onClose
    super.onClose();
  }
}
