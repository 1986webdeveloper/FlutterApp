import 'package:flutter/material.dart';
import 'package:FlutterApp/Menu/MenuScreen.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuScreen(),
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontFamily: "Raleway", fontSize: 20.0),
        ),
      ),
      body: Container(),
    );
  }
}
