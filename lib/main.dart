import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_app/Screens/LoginPage.dart';
import 'package:project_app/Screens/register.dart';

int? isFirstTime;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isFirstTime =prefs.getInt('onBoard');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: isFirstTime !=0 ?const Register() : const Login(),
  ));

}
