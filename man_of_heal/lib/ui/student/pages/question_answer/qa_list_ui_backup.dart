import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/models/subscription_model.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/student/pages/question_answer/widgets/ask_question_ui.dart';
import 'package:man_of_heal/ui/student/pages/question_answer/widgets/questions_widget.dart';

class QuestionAnswerListBackUp extends StatelessWidget {
  final RxInt? initialTime = 0.obs;

  @override
  Widget build(BuildContext context) {
    Subscription? subscription;

    print('Subscribe ${subscriptionController.subsFirebase.isBlank!}');
    if (!subscriptionController.subsFirebase.isBlank!) {
      /*print('inside check blank');
      subscriptionController.subsFirebase.map((data) => {
        print('inside'),
        subscription = data,
          });*/
      subscription = subscriptionController.subsFirebase.value!;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FormVerticalSpace(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                //controller: qaController.searchController,
                onChanged: (search) => {qaController.handleSearch(search)},
                decoration: new InputDecoration(
                    contentPadding: EdgeInsets.all(12.0),
                    prefixIcon: new Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: 'Search Questions ...'),
              ),
            ),
            FormVerticalSpace(
              height: 5,
            ),
            !subscriptionController.subsFirebase.isBlank! &&
                    subscription != null
                ? _headerWidgets(subscription)
                : Text('Subscriber no blank $subscription'),
            //Expanded(child: QAWidget())
          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.end,
      floatingActionButton: !subscriptionController.subsFirebase.isBlank! &&
              subscription != null &&
              subscription.noOfAskedQuestion! > 0
          ? FloatingActionButton.extended(
              onPressed: () {
                Get.to(() => AskQuestionUI());
              },
              label: const Text(
                'Ask Question',
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.quiz_outlined,
                color: Colors.white,
              ),
              backgroundColor: Colors.deepPurple,
            )
          : null,
    );
  }

  Widget _headerWidgets(Subscription subscription) {
    int _duration = _getSecondsFromNowOnwardDate(subscription);
    if (subscription.noOfAskedQuestion! <= 0 &&
        subscription.nextQuestionAt != null &&
        _duration > initialTime!.value) {
      return Container(
        height: 100,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Text('Next Question'),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Obx(
                    () => CountDownProgressIndicator(
                      valueColor: Colors.deepPurple,
                      backgroundColor: Colors.black26,
                      initialPosition: initialTime!.value,
                      duration: _duration,
                      strokeWidth: 3,
                      timeTextStyle:
                          TextStyle(color: Colors.deepPurple, fontSize: 8),
                      timeFormatter: (seconds) {
                        return Duration(seconds: seconds)
                            .toString()
                            .split('.')[0]
                            .padLeft(8, '0');
                      },
                      onComplete: () {
                        subscriptionController
                            .onCompletionOfThreeDays(subscription);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Container(
      height: 100,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Question Quota',
              ),
              Text(
                '${subscription.noOfAskedQuestion}/${subscription.questionQuota}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getSecondsFromNowOnwardDate(Subscription subscription) {
    DateTime nextQuestionDateTime = DateTime.fromMicrosecondsSinceEpoch(
        subscription.nextQuestionAt!.microsecondsSinceEpoch);
    DateTime createdQusDateTime = DateTime.fromMicrosecondsSinceEpoch(
        subscription.questionCreatedAt!.microsecondsSinceEpoch);

    initialTime!.value =
        new DateTime.now().difference(createdQusDateTime).inSeconds;

    print('init Time ${new DateTime.now().difference(createdQusDateTime).inSeconds}');
    print('next Question Time ${nextQuestionDateTime.difference(new DateTime.now()).inSeconds}');
    return nextQuestionDateTime.difference(new DateTime.now()).inSeconds;
  }

  int _getNextQuestionInitialTime(Timestamp? timestamp) {
    DateTime dateTime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp!.microsecondsSinceEpoch);

    return DateTime.now().difference(dateTime).inSeconds;
  }
}
