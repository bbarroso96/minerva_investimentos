

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minerva_investimentos/data/db_data.dart';
import 'package:minerva_investimentos/data/local_data.dart';
import 'package:minerva_investimentos/models/asset_model.dart';
import 'package:minerva_investimentos/utils/router.dart';
import 'package:path/path.dart';

class LogInProvider extends ChangeNotifier
{
  bool _obscurePassword;

  String _password;
  String _enteredPassword;

  String _description;

  LocalData _localData = LocalData();

  Icon _obscurePasswordIcon;

  LogInProvider()
  {
    _obscurePassword = true;

    _obscurePasswordIcon = Icon(Icons.visibility_off);

    _init();
    
  }

  void _init()  async 
  {
    _password = await _localData.getUserPin();

    //Caso já exista uma senha cadastrada
    if(_password != null)
    {
      _description =  "Insira o PIN ou entre com a digital";
    }
    else
    {
      _description = "Por favor cadastre um PIN";
    }
    notifyListeners();  


  } 


 //Altera visibilidade do campo de senha
 Future<void> toggleObscurePassword() async {
    _obscurePassword ^= true;

    if(_obscurePassword == true)
    {
      _obscurePasswordIcon = Icon(Icons.visibility_off);
    }
    else
    {
      _obscurePasswordIcon = Icon(Icons.visibility);
    }
    notifyListeners();

  }

  void submitLogIn(BuildContext context) async {
   
    //Caso não exista uma senha cadastrada
    //Salva a senha inserida
    if(_password == null)
    {
      _localData.saveUserPin(_enteredPassword);
      _description = "Senha cadastrada com sucesso";
      notifyListeners();

      Future.delayed(Duration(milliseconds: 1000));
       Navigator.pushReplacementNamed(context, homeRoute);
    }

    //Caso já exista uma senha, verifica se está correta
    else
    {
      //Caso a senha seja válida, reliza a navegação para Home
      if(_password == _enteredPassword)
      {
          Navigator.pushReplacementNamed(context, homeRoute);
      }
      //Caso a senha esteja incorreta, altera texto para notificar o usuário
      else
      {
        _description = "Senha incorreta";
        notifyListeners();
      }
    }


  }

  bool get obscurePassword => _obscurePassword;
  Icon get obscurePasswordIcon => _obscurePasswordIcon;

  String get password => _enteredPassword;
  void set password(String password)=> _enteredPassword = password;

  String get desciption => _description;
}