import 'package:flutter/material.dart';

class QuestionOptions extends StatelessWidget {
  const QuestionOptions({
    Key? key,
    this.text,
    this.index,
    this.onPress,
  }) : super(key: key);
  
  final String? text;
  final int? index;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
