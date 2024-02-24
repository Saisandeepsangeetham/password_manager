import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AddPassword extends StatefulWidget {
  const AddPassword({super.key});

  @override
  State<AddPassword> createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  final focus = FocusNode();
  final titlecontroller = TextEditingController();
  final urlcontroller = TextEditingController(text: "https://www.");
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final notescontroller = TextEditingController();

  bool isObsecured = true;

  final GlobalKey<FormState> _addPasswordformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width*0.07,
          ),
          child: Form(
            key: _addPasswordformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add Password",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: size.height*0.01,),
                const Text(
                  "Fill in the details below to save the password",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey
                  ),
                ),
                SizedBox(height: size.height*0.01,),
                const Row(
                  children: [
                    Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      "*",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: titlecontroller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: RequiredValidator(errorText: 'Title is required').call,
                  decoration: const InputDecoration(
                    filled: true
                  ),
                ),
                SizedBox(height: size.height*0.01,),
                const Row(
                  children: [
                    Text(
                      "url",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      "*",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: urlcontroller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: RequiredValidator(errorText: 'url is required').call,
                  decoration: const InputDecoration(
                      filled: true
                  ),
                ),
                SizedBox(height: size.height*0.01,),
                const Row(
                  children: [
                    Text(
                      "User Name",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      "*",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: usernamecontroller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: RequiredValidator(errorText: 'username is required').call,
                  decoration: const InputDecoration(
                      filled: true
                  ),
                ),
                SizedBox(height: size.height*0.01,),
                const Row(
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      "*",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                TextFormField(
                  obscureText: isObsecured,
                  controller: passwordcontroller,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  //need to implement onfield submitted
                  //
                  //
                  validator: RequiredValidator(errorText: 'password is required').call,
                  decoration: InputDecoration(
                      filled: true,
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
                SizedBox(
                  height: size.height * 0.02,
                ),
                const Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 2,
                  focusNode: focus,
                  controller: notescontroller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // validate(context);
                    },
                    child: const Text('Save'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
