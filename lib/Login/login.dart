import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'dart:async';
import 'package:FlutterApp/Model/loginModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:FlutterApp/NetworkUtil.dart';
import 'package:FlutterApp/constants.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  var _email = TextEditingController();
  var _password = TextEditingController();

  var _emailFocus = new FocusNode();
  var _passwordFocus = new FocusNode();

  var loginData = LoginModel();
  var _getAllData = false;

  Future<LoginModel> login() async {
    var urlString = '$baseUrl/login';
    print(urlString);
    return NetworkUtil.internal().post(urlString, body: {
      'email': _email.text,
      'password': _password.text
    }).then((dynamic res) {
      setState(() {
        _getAllData = false;
      });
      var data = LoginModel.map(res);
      if (data.status == true) {
        dispalyMessage(data.message);
        App.localStorage.setBool(kAlreadyLogin, true);
        App.localStorage.setInt(kUserId, data.data[0].id);
        Navigator.pushNamed(context, "/HomeScreen");
      }
      return data;
    });
  }

  void dispalyMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white);
  }

  bool validation() {
    var isSuccess = true;
    var strEmail = _email.text;
    var strPassword = _password.text;
    if (strEmail == "") {
      dispalyMessage("Please enter email address");
      isSuccess = false;
    } else if (strPassword == "") {
      dispalyMessage("Please enter password");
      isSuccess = false;
    } else if (isEmail(strEmail) == false) {
      dispalyMessage("Please enter valid email");
      isSuccess = false;
    }
    return isSuccess;
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardAction(
            focusNode: _emailFocus,
            displayCloseWidget: true,
          ),
          KeyboardAction(
            focusNode: _passwordFocus,
            displayCloseWidget: true,
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardActions(
        config: _buildConfig(context),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 50, 30, 50),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.verified_user,
                    color: Colors.black38,
                    size: 40,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  new TextField(
                    controller: _email,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocus,
                    decoration: InputDecoration(labelText: "Email address"),
                    onSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 17.0,
                        color: Colors.black),
                  ),
                  new TextField(
                    controller: _password,
                    autocorrect: false,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _passwordFocus,
                    decoration: InputDecoration(labelText: "Password"),
                    onSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 17.0,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 44,
                    width: _getAllData == false ? double.infinity : 44,
                    child: _getAllData == false
                        ? RaisedButton(
                            textColor: Colors.white,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 20.0, fontFamily: 'Raleway'),
                            ),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              if (validation() == true) {
                                setState(() {
                                  _getAllData = true;
                                });
                                Navigator.pushNamed(context, "/HomeScreen");
                                //login();
                              }
                            },
                          )
                        : CircularProgressIndicator(),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  FlatButton(
                    child: Container(
                      child: Text(
                        "Don't you have an account? Sign up",
                        style: TextStyle(fontSize: 16.0, fontFamily: 'Raleway'),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/SignUp");
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(fontSize: 16.0, fontFamily: 'Raleway'),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
