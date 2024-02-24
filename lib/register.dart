import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isObsecured = true;
  final password_controller = TextEditingController();
  final confirm_password_controller = TextEditingController();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  //validate function need to be there..

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Password Manager',
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white70
          ),
        ),
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("")
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child:Center(
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
            SizedBox(height: size.width*0.07,),
            Text('Register a New Master Password',
              style: TextStyle(
                  fontSize: 18.0,
                  color:Colors.grey.shade600
              ),
            ),
            SizedBox(height: size.width*0.07,),
            TextFormField(
              obscureText: isObsecured,
              controller: password_controller,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              validator: passwordValidator.call,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                border:const OutlineInputBorder(),
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
            SizedBox(height: size.width*0.03,),
            TextFormField(
              obscureText: isObsecured,
              controller: confirm_password_controller,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              validator: (val) => MatchValidator(
                  errorText: 'passwords do not match')
                  .validateMatch(val!, password_controller.text.trim()),
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                filled: true,
                border:const OutlineInputBorder(),
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
            SizedBox(height: size.width*0.03,),
            ElevatedButton(onPressed: (){
              // validate() need to define in the above using the database
            },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  backgroundColor: Colors.indigoAccent,
                ),
                child:const Text(
                  'Register',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white70
                  ),
                )
            ),
            SizedBox(height: size.width*0.22,),
            // Divider(thickness: 1,color: Colors.black,),
            const Text(
              'Note that if the master password is lost,the stored '
                  'data cannot be recovered because of the missing '
                  'sync option. it is strongly recommended that you '
                  'remember your Master Password',
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )
    );
  }
}
