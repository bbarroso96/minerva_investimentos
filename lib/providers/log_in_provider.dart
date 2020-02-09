

import 'package:flutter/cupertino.dart';
import 'package:minerva_investimentos/utils/router.dart';
import 'package:path/path.dart';

class LogInProvider extends ChangeNotifier
{
  bool _obscurePassword;

  String _password;

  LogInProvider(){
    _obscurePassword = true;
    
    _password = "1"; //TODO: armazenar e criar a senha
  }


 void toggleObscurePassword() {
    _obscurePassword ^= true;
    notifyListeners();
  }

  bool submitLogIn(BuildContext context) {
   
   if(_password == "123")
   {
    Navigator.pushReplacementNamed(context, homeRoute);
   }
   
  }

   bool get obscurePassword => _obscurePassword;
   String get password => _password;
   void set password(String password)=> _password = password;

}