import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Load a Lottie file from your assets
            // Lottie.asset('assets/LottieLogo1.json'),
            Center(
              child: Lottie.network(
                  'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),
            ),
            SizedBox(
              height: 40,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
