import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoGraphicHeader extends StatelessWidget {
  LogoGraphicHeader();

  @override
  Widget build(BuildContext context) {
    String _imageLogo = 'assets/icons/logo.svg';
    return Hero(
      tag: 'App Logo',
      child: CircleAvatar(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.transparent,
          radius: 20.0,
          child: ClipOval(
            child: SvgPicture.asset(
              _imageLogo,
              fit: BoxFit.cover,
              width: 200.0,
              height: 200.0,
            ),
          )),
    );
  }
}
