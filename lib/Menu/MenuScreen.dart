import 'package:flutter/material.dart';
import 'menuCell.dart';
import 'package:picture_on_map/constants.dart';
import 'package:picture_on_map/Login/LogoutScreen.dart';

class MenuScreen extends StatelessWidget {
  @override
    Drawer build(BuildContext context) {
      
      return Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Container(
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 45,
                    ),
                    Text("Mark thomas", style:TextStyle(fontFamily: 'Raleway',fontSize: 23,color: Colors.white)),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  child: MenuCell(name: "Home",menu: Icons.home,),
                  onTap: () {
                    Navigator.pushNamed(context, "/HomeScreen");
                  },
                ),
                GestureDetector(
                  child: MenuCell(name: "My Profile",menu: Icons.perm_identity,),
                  onTap: (){
                    Navigator.pushNamed(context, "/Profile");
                  },
                ),
                GestureDetector(
                  child: MenuCell(name: "Change Password",menu: Icons.vpn_key,),
                ),
                GestureDetector(
                  child: MenuCell(name: "Share App",menu: Icons.share,),
                  onTap: () {
                    
                  },
                ),
                GestureDetector(
                  child: MenuCell(name: "Logout",menu: Icons.power_settings_new,),
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(context: context,builder:(BuildContext context) => LogoutScreen());
                  },
                ),
              ],
            )
          ],
        ),
      );
    }
}