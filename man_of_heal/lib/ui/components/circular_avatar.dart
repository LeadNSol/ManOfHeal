import 'package:flutter/material.dart';

class CircularAvatar extends StatelessWidget {
  const CircularAvatar({
    Key? key,
    this.padding = 1,
    this.radius = 25,
    this.imageUrl = "https://cdn-icons-png.flaticon.com/128/3011/3011270.png",

  }) : super(key: key);

  final double? padding, radius;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: EdgeInsets.all(padding!),
        child: Center(
          child: CircleAvatar(
            radius: radius,
            backgroundImage: NetworkImage(imageUrl!.isNotEmpty ? imageUrl! : "https://cdn-icons-png.flaticon.com/128/3011/3011270.png"
              /* authController.userModel!.value!.photoUrl!.isEmpty
                  ? "https://cdn-icons-png.flaticon.com/128/3011/3011270.png"
                  : authController.userModel!.value!.photoUrl!*/
              ,
            ),
          ),
        ),

    );
  }
}
