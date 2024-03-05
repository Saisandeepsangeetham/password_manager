import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_app/changemasterpassword.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  bool didAuthenticate = false;
  Future<void> authenticate() async {
    try {
      var localAuth = LocalAuthentication();
      didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Authenticate to view password!',
        options: AuthenticationOptions(biometricOnly: true, stickyAuth: true),
      );
      setState(() {});
    } catch (e) {
      print('Authentication Error: $e');
    }
  }
  @override
  void initState(){
    super.initState();
    authenticate();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:const Text('Settings',
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.white70,
          fontWeight: FontWeight.w500
          ),
        ),
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
      ),
      body: SafeArea(
        child:Column(
            children: [
              SizedBox(height: size.height*0.02,),
              Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                    backgroundColor: Colors.grey
                  ),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Change Master Password',
                      style: TextStyle(fontSize: 18.0, color: Colors.white70),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isObsecured = true;
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _loginformKey = GlobalKey<FormState>();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'Password must have at least one special character'),
  ]);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
            child: Form(
              key: _loginformKey,
              child: Column(
                children: [
                  SizedBox(height: size.width * 0.05),
                  Text(
                    "Enter your Master Password to confirm you.",
                    style: TextStyle(fontSize: 18.0, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: size.width * 0.09),
                  TextFormField(
                    obscureText: isObsecured,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    validator: passwordValidator.call,
                    decoration: InputDecoration(
                      labelText: "Password",
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
                  SizedBox(height: size.width * 0.07),
                  ElevatedButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus!.unfocus();
                      if (_loginformKey.currentState!.validate()) {
                        final prefs = await SharedPreferences.getInstance(); // Get an instance of SharedPreferences
                        String? storedPassword = prefs.getString('password');
                        if (storedPassword == passwordController.text.trim()) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChangePasswordPage()));
                          print("Password verified");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Incorrect password. Please try again.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      backgroundColor: Colors.indigoAccent,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18.0, color: Colors.white70),
                    ),
                  ),

                  SizedBox(height: size.width * 0.15),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
