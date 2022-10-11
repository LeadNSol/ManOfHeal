import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/models/user_model.dart';
import 'package:man_of_heal/ui/components/circular_avatar.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class HeaderWidget extends StatelessWidget {
  final QuestionModel questionModel;

  HeaderWidget(this.questionModel);

  @override
  Widget build(BuildContext context) {
    var name = "fetching...".obs;
    var photoUrl = "".obs;

    getUserById().then((UserModel model) {
      name.value = model.name!;
      photoUrl.value = model.photoUrl!;
    });

    // print('photo Url${authController.userModel.value!.photoUrl}');

    //TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //IconButton(onPressed: () {}, icon: Icon(Icons.edit_rounded)),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Obx(
            () => CircularAvatar(
              padding: 1,
              imageUrl: photoUrl.value,
            ),
          ),

          /*Padding(
            padding: const EdgeInsets.all(1.0),
            child: Obx(
                  () => Image.network(photoUrl.value.isEmpty
                  ? "https://cdn-icons-png.flaticon.com/128/3011/3011270.png"
                  : photoUrl.value),
            ),
          ),*/
        ),
        SizedBox(
          width: 5,
        ),
        Obx(
          () => Text(
            '${name.value}',
            style: AppThemes.header2,
          ),
        ),
      ],
    );
  }

  Future<UserModel> getUserById() {
    return authController.getUserById(questionModel.studentId!);
  }
}
