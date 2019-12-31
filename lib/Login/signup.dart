import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:picture_on_map/Model/loginModel.dart';
import 'package:picture_on_map/constants.dart';
import 'package:picture_on_map/NetworkUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:async';
import 'dart:io';


class SignUp extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      return _SignUpState();
    }
}

class _SignUpState extends State<SignUp> {
  var _firstName = TextEditingController();
  var _lastName = TextEditingController();
  var _emailAddress = TextEditingController();
  var _mobileNumber = TextEditingController();
  var _password = TextEditingController();
  var _confirmPassword = TextEditingController();

  var _firstNameFocus = new FocusNode();
  var _lastNameFocus = new FocusNode();
  var _emailAddressFocus = new FocusNode();
  var _mobileNumberFocus = new FocusNode();
  var _passwordFocus = new FocusNode();
  var _confirmPasswordFocus = new FocusNode();
  File _image;

  var _getAllData = false;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<LoginModel> signupfun() async {
    var urlString = '$baseUrl/registration';
    print(urlString);
    return NetworkUtil.internal().post(urlString, body: {
      'firstname': _firstName.text,
      'lastname': _lastName.text,
      'email': _emailAddress.text,
      'mobile':_mobileNumber.text,
      'password': _password.text
    }).then((dynamic res) {
      setState(() {
        _getAllData = false;
      });
      var data = LoginModel.map(res);
      if (data.status == true) {
        
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
    var strFirstName = _firstName.text;
    var strLastName = _lastName.text;
    var strMobile = _mobileNumber.text;
    var strEmail = _emailAddress.text;
    var strPassword = _password.text;
    var strConfirmPassword = _confirmPassword.text;
    if (strFirstName == "") {
      dispalyMessage("Please enter first name");
      isSuccess = false;
    } else if (strLastName == "") {
      dispalyMessage("Please enter last name");
      isSuccess = false;
    } else if (strEmail == "") {
      dispalyMessage("Please enter email address");
      isSuccess = false;
    } else if (strMobile == "") {
      dispalyMessage("Please enter mobile number");
      isSuccess = false;
    } else if (strPassword == "") {
      dispalyMessage("Please enter password");
      isSuccess = false;
    } else if (strConfirmPassword == "") {
      dispalyMessage("Please enter confirm password");
      isSuccess = false;
    } else if (isEmail(strEmail) == false) {
      dispalyMessage("Please enter valid email");
      isSuccess = false;
    } else if (strConfirmPassword != strPassword) {
      dispalyMessage("Password not match with confirm password");
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
            focusNode: _firstNameFocus,
            displayCloseWidget: true,
          ),
          KeyboardAction(
            focusNode: _lastNameFocus,
            displayCloseWidget: true,
          ),
          KeyboardAction(
            focusNode: _emailAddressFocus,
            displayCloseWidget: true,
          ),
          KeyboardAction(
            focusNode: _mobileNumberFocus,
            displayCloseWidget: true,
          ),
          KeyboardAction(
            focusNode: _passwordFocus,
            displayCloseWidget: true,
          ),
          KeyboardAction(
            focusNode: _confirmPasswordFocus,
            displayCloseWidget: true,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign up"),
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: KeyboardActions(
        // keyboardActionsPlatform: KeyboardActionsPlatform.ALL, //optional
        // keyboardBarColor: Colors.grey[200], //optional
        // nextFocus: true, //optional
        // actions: [
          // KeyboardAction(
          //   focusNode: _firstNameFocus,
          //   displayCloseWidget: true,
          // ),
          // KeyboardAction(
          //   focusNode: _lastNameFocus,
          //   displayCloseWidget: true,
          // ),
          // KeyboardAction(
          //   focusNode: _emailAddressFocus,
          //   displayCloseWidget: true,
          // ),
          // KeyboardAction(
          //   focusNode: _mobileNumberFocus,
          //   displayCloseWidget: true,
          // ),
          // KeyboardAction(
          //   focusNode: _passwordFocus,
          //   displayCloseWidget: true,
          // ),
          // KeyboardAction(
          //   focusNode: _confirmPasswordFocus,
          //   displayCloseWidget: true,
          // ),
        // ],
        config: _buildConfig(context),
        child: Container(
          child: SingleChildScrollView(
            child: Container(
            margin: EdgeInsets.fromLTRB(30, 50, 30, 50),
            child: Column(children: <Widget>[
              // GestureDetector(
              //   onTap: () {
              //     getImage();
              //   },
              //   child: Container(
              //     width: 150,
              //     height: 150,
              //     child: _image == null ? Image.asset("assets/user-icon.png")
              //       : new CircleAvatar(backgroundImage: new FileImage(_image),
              //        radius: 75.0,
              //        backgroundColor: Colors.white,
              //        ),
              //   ),
               
              // ),
              new TextField(
                controller: _firstName,autocorrect: false,
                keyboardType: TextInputType.text,
                maxLength: 30,
                focusNode: _firstNameFocus,
                decoration: InputDecoration(
                  labelText: "First Name"
                ),
                onSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(_lastNameFocus);
                },
              ),
              new TextField(
                controller: _lastName,autocorrect: false,
                keyboardType: TextInputType.text,
                focusNode: _lastNameFocus,
                maxLength: 30,
                decoration: InputDecoration(
                  labelText: "Last Name"
                ),
                onSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(_emailAddressFocus);
                },
              ),
              new TextField(
                controller: _emailAddress,autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                focusNode: _emailAddressFocus,
                decoration: InputDecoration(
                  labelText: "Email address"
                ),
                onSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(_mobileNumberFocus);
                },
              ),
              new TextField(
                controller: _mobileNumber,autocorrect: false,
                keyboardType: TextInputType.phone,
                focusNode: _mobileNumberFocus,
                maxLength: 10,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Mobile Number"
                ),
                onSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
              ),
              new TextField(
                controller: _password,autocorrect: false,
                keyboardType: TextInputType.text,
                focusNode: _passwordFocus,
                maxLength: 30,
                decoration: InputDecoration(
                  labelText: "Password"
                ),
                obscureText: true,
                onSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(_confirmPasswordFocus);
                },
              ),
              new TextField(
                controller: _confirmPassword,autocorrect: false,
                keyboardType: TextInputType.text,
                focusNode: _confirmPasswordFocus,
                maxLength: 30,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  
                ),
                obscureText: true,
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              SizedBox(
                    height: 44,
                    width: _getAllData == false ? double.infinity : 44,
                    child: _getAllData == false
                        ? RaisedButton(
                            textColor: Colors.white,
                            child: Text(
                              "Sign Up",
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
                                //signupfun();
                              }
                            },
                          )
                        : CircularProgressIndicator(),
                  ),
            ],
        )
        ),
          ),
        ),
        )
      );
  }
}
