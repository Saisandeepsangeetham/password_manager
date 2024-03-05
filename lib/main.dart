import 'package:project_app/addPasswordProvider.dart';
import 'package:project_app/generatepassword.dart';
import 'package:project_app/Screens/LoginPage.dart';
import 'package:project_app/Database/databasehelper.dart';
import 'package:flutter/material.dart';
import 'package:project_app/Screens/register.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isFirstTime;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isFirstTime =prefs.getInt('onBoard');
  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:
      [
        ChangeNotifierProvider(
          create: (context) => AddPasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DatabaseService(),
        ),
        ChangeNotifierProvider(
          create: (context) => GeneratePassword(),
        ),
      ],
      builder: (context,child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: isFirstTime !=0 ?const Register() : const Login(),
        );
      },
    );
  }
}
