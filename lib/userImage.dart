import 'package:flutter/material.dart';

class UserImageIcon extends StatelessWidget {
  Image image;
  @override
    Widget build(BuildContext context) {
      return Container(
                child: image == null ? Image.asset('assets/user-icon.png',width: 150,height: 150,) : image,
              );
    }
}