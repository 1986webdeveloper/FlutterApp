import 'package:flutter/material.dart';
import 'package:picture_on_map/constants.dart';

class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                ),
                height: 50,
                padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                width: double.infinity,
                child: Text("Logout",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 18.0,
                        color: Colors.white)),
              ),
              Container(
                padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                child: Text("Are you sure you want to logout?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Raleway', fontSize: 18.0)),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text("Yes",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontFamily: 'Raleway', fontSize: 18.0)),
                      onPressed: () {
                        App.localStorage.setBool(kAlreadyLogin, false);
                        Navigator.pushNamed(context, '/Login');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text("No",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontFamily: 'Raleway', fontSize: 18.0)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
