import 'dart:math';

import 'package:flutter/material.dart';

class GeneratePassword with ChangeNotifier{
  double _passwordstrength = 0;
  double get passwordstrength => _passwordstrength;

  double _length = 8;
  double get length => _length;

  set length (double value){
    _length = value.clamp(8, 20);
    notifyListeners();
  }

  String _generatedpassword ='';
  String get generatedpassword => _generatedpassword;

  void get generatepassword{
    try{
      var randompass = generaterandompassword(
        length: _length.toInt()
      );
      _generatedpassword = randompass;
      _passwordstrength = checkpasswordstrength(
        password: _generatedpassword,
      );
    }catch(e){
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  String generaterandompassword({
    required int length}){
    final random = Random.secure();

    const letterlowercase  = "abcdefghijklmnopqrstuvwxyz";
    const letteruppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const numbers = '0123456789';
    const special = '!@#\$%^&*()=+';

    List<String> characters = [];

    characters.addAll(letterlowercase.split(''));
    characters.addAll(letteruppercase.split(''));
    characters.addAll(numbers.split(''));
    characters.addAll(special.split(''));

    String password = '';
    for(int i = 0;i<length;i++){
      password+=characters[random.nextInt(characters.length)];
    }
    int minimumspecialcharactercount = (length/4).ceil()-1;
    int minimumnumbercount = (length/4).ceil()-1;

    int specialCharCount = password.split('').where((char) => special.contains(char)).length;
    int numberCount = password.split('').where((char) => numbers.contains(char)).length;

    if (specialCharCount < minimumspecialcharactercount || numberCount < minimumnumbercount) {
      return generaterandompassword(
        length: length,
      );
    }
    return password;
  }

  double checkpasswordstrength({required String password}){
    if(password.isEmpty) return 0.0;
    double bonus;
    if(RegExp(r'^[a-z]*$').hasMatch(password)) {
      bonus = 1.0;
    }else if(RegExp(r'^[a-z0-9]*$').hasMatch(password)){
      bonus = 1.2;
    }else if(RegExp(r'^[a-zA-Z]*$').hasMatch(password)){
      bonus =1.3;
    } else if (RegExp(r'^[a-z\-_!?]*$').hasMatch(password)) {
      bonus = 1.3;
    } else if (RegExp(r'^[a-zA-Z0-9]*$').hasMatch(password)) {
      bonus = 1.5;
    } else {
      bonus = 1.8;
    }
    double logistic(double x) {
      return 1.0 / (1.0 + exp(-x));
    }

    double curve(double x) {
      return logistic((x / 3.0) - 4.0);
    }

    return curve(password.length * bonus);
  }

}

