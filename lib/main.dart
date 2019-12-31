// We cant change the main funcation named in flutter.
// class can be used with uper camel case not allowed the dash and other special character
// use any libarary of the flutter in class use extend which work as inheritance
// Scaffold is used to create the page with white background and also add the app bar and so on.
// Use ctrl + space to see the property on the object and to see the property just move over the object
// Use shift + alt + f to formate the code
// void main() => runApp(MyApp()); We can make the online funcation like this
// statelessWidget not work with internal data so any data change internally its not called
// don't use the meterial app twice in your app beacuse its make its own navigation which cause of not showing back button.

import 'package:flutter/material.dart';
import './Login/signup.dart';
import './Login/login.dart';
import './Home/HomeScreen.dart';
import './Home/Profile.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences localStorage = await SharedPreferences.getInstance();
  var storedValue = localStorage.getBool(kAlreadyLogin);
  start();
  var goToScreen = false;
  if (storedValue == null) {
    goToScreen = false;
  } else if (storedValue == true) {
    goToScreen = true;
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Color.fromRGBO(60, 88, 158, 1.0),
      primarySwatch: Colors.deepOrange
    ),
    home: goToScreen == false ? Login() : HomeScreen(),
    routes: <String, WidgetBuilder> {
      "/Login": (BuildContext context) => Login(),
      "/SignUp": (BuildContext context) => SignUp(),
      "/HomeScreen": (BuildContext context) => HomeScreen(),
      "/Profile": (BuildContext context) => Profile()
    }
  )
  );
  
}

Future<Null> start() async {
    await App.init(); //prints 'Bob'
  }

 




