import 'package:flutter/material.dart';

class DoubleBackPressToExit extends StatelessWidget {
  const DoubleBackPressToExit({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    DateTime pre_backPress = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        final timeGap = DateTime.now().difference(pre_backPress);
        final cantExit = timeGap >= Duration(seconds: 2);
        pre_backPress = DateTime.now();
        if (cantExit) {
          //show snack bar
          final snack = SnackBar(
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        } else {
          return true;
        }
      },
      child: child!,
    );
  }
}
