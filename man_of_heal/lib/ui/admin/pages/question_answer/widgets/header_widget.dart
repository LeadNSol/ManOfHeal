import 'package:flutter/material.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/qa_model.dart';
import 'package:man_of_heal/models/user_model.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatelessWidget {
  final QuestionModel questionModel;

  HeaderWidget(this.questionModel);

  @override
  Widget build(BuildContext context) {
    var name = "fetching...".obs;

    getUserById().then((UserModel model) {
      name.value = model.name!;
    });

    TextTheme textTheme = Theme.of(context).textTheme;
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
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Image.network(
                "https://cdn-icons-png.flaticon.com/128/3011/3011270.png"),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Obx(()=>Text(
            '${name.value}',
            style: textTheme.bodyText1!
                .copyWith(fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),
      ],
    );
  }

  Future<UserModel> getUserById() {
    return authController.getUserById(questionModel.studentId!);
  }
}
