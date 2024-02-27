import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/LoginPage.dart';
import 'Screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: isFirstTime ? Register() : Login(),
  ));

  if (isFirstTime) {
    await prefs.setBool('isFirstTime', false);
  }
}
