import 'package:shared_preferences/shared_preferences.dart';


const baseUrl = 'http://192.168.1.101/index.php/api';
const kAlreadyLogin = 'kAlreadyLogin';
const kUserId = 'kUserId';

class App {      
  static SharedPreferences localStorage;
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }
}