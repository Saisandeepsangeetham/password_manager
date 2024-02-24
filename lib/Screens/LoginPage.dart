import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool isObsecured = true;
  final password_controller = TextEditingController();
  final GlobalKey<FormState> _loginformKey = GlobalKey<FormState>();

  //need to implement the function check password...

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white70
          ),
        ),
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width*0.07
            ),
            child: Form(
              key: _loginformKey,
              child: Column(
                children: [
                  SizedBox(height: size.width*0.07,),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child:Center(
                      child: Container(
                        width: 200.0,
                        height: 200.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.blueGrey),
                        ),
                        child: Image(image: AssetImage('assets/login.jpg')),
                      ),
                    ),
                  ),
                  SizedBox(height: size.width*0.05,),
                  Text(
                    "Enter your Master Password",
                     style:TextStyle(
                       fontSize: 18.0,
                       color: Colors.grey.shade600
                     )
                  ),
                  SizedBox(height: size.width*0.09,),
                  TextFormField(
                    obscureText: isObsecured,
                    controller: password_controller,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    validator: passwordValidator.call,
                    decoration: InputDecoration(
                      labelText: "Password",
                      filled: true,
                      border: const OutlineInputBorder(),
                      suffix: InkWell(
                        child: Icon(
                          isObsecured
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onTap: () {
                          setState(() {
                            isObsecured = !isObsecured;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: size.width*0.07,),
                  ElevatedButton(onPressed: (){
                    //need to implement the password validate..
                  }, style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30,vertical:12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                    backgroundColor: Colors.indigoAccent,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white70
                      ),
                    ),
                  ),
                  SizedBox(height: size.width*0.15,),
                  const Text(
                    'Once you save a password, you\'ll '
                      'always have it when you need it. logging in is fast '
                      'and easy. And the password is securely stored!',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
