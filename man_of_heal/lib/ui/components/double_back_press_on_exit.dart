import 'package:flutter/material.dart';

class DoubleBackPressToExit extends StatelessWidget {
  const DoubleBackPressToExit({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    DateTime preBackPress = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        final timeGap = DateTime.now().difference(preBackPress);
        final cantExit = timeGap >= Duration(seconds: 2);
        preBackPress = DateTime.now();
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
