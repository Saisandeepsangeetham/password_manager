import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPage.dart';
import 'package:project_app/HomePage.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isObsecured = true;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'Password must have at least one special character'),
  ]);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Password Manager',
          style: TextStyle(fontSize: 25.0, color: Colors.white70),
        ),
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Container(
                    width: 110.0,
                    height: 110.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      border: Border.all(color: Colors.blueGrey),
                    ),
                    child: Image(image: AssetImage('assets/logo.png')),
                  ),
                ),
              ),
              SizedBox(height: size.width * 0.07),
              Text(
                'Register a New Master Password',
                style: TextStyle(fontSize: 18.0, color: Colors.grey.shade600),
              ),
              SizedBox(height: size.width * 0.07),
              TextFormField(
                obscureText: isObsecured,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validator: passwordValidator.call,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  border: const OutlineInputBorder(),
                  suffix: InkWell(
                    child: Icon(
                      isObsecured ? Icons.visibility : Icons.visibility_off,
                    ),
                    onTap: () {
                      setState(() {
                        isObsecured = !isObsecured;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: size.width * 0.03),
              TextFormField(
                obscureText: isObsecured,
                controller: confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validator: (val) => MatchValidator(errorText: 'Passwords do not match')
                    .validateMatch(val!, passwordController.text.trim()),
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  filled: true,
                  border: const OutlineInputBorder(),
                  suffix: InkWell(
                    child: Icon(
                      isObsecured ? Icons.visibility : Icons.visibility_off,
                    ),
                    onTap: () {
                      setState(() {
                        isObsecured = !isObsecured;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: size.width * 0.03),
              ElevatedButton(
                onPressed: () async { // 2. Use async for SharedPreferences
                  if (_formKey.currentState!.validate()) {
                    final prefs = await SharedPreferences.getInstance(); // Get an instance of SharedPreferences
                    prefs.setString('password', passwordController.text.trim()); // Store the password
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Registration Successful'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login())); // Navigate to the login screen after registration
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: Colors.indigoAccent,
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 18.0, color: Colors.white70),
                ),
              ),
              SizedBox(height: size.width * 0.22),
              const Text(
                'Note that if the master password is lost, the stored '
                    'data cannot be recovered because of the missing '
                    'sync option. It is strongly recommended that you '
                    'remember your Master Password',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
