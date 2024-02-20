import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login Page',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w500
            ),
          ),
          backgroundColor: Colors.indigoAccent,
          centerTitle: true,
        ),
        body: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Loginform(),
        ),
      ),
    );
  }
}

class Loginform extends StatefulWidget {
  const Loginform({super.key});

  @override
  State<Loginform> createState() => _LoginformState();
}

class _LoginformState extends State<Loginform> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget> [
        Padding(
          padding: const EdgeInsets.only(top:20.0),
          child: Center(
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.blueGrey)),
              child: Image.asset('assets/logo.png'),
            ),
          ),
        ),
        const SizedBox(height: 10.0,),
        TextField(
          controller: emailcontroller,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: const Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0)
            )
          ),
        ),
        const SizedBox(height: 10.0,),
        TextField(
          controller: passwordcontroller,
          decoration: InputDecoration(
            labelText: "Password",
            prefixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          suffixIcon:const Align(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: Icon(Icons.remove_red_eye),
            ),
          ),
        ),
        const SizedBox(height: 20.0,),
        ElevatedButton(onPressed: (){},
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              backgroundColor: Colors.indigoAccent
            ),
            child: const Text("Login",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white70
            ),),
        ),
      ],
    );
  }
}

