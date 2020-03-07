import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:minerva_investimentos/data/db_data.dart';
import 'package:minerva_investimentos/data/local_data.dart';
import 'package:minerva_investimentos/data/marked_data.dart';
import 'package:minerva_investimentos/models/asset_model.dart';
import 'package:minerva_investimentos/providers/alpha_vantage_provider.dart';
import 'package:minerva_investimentos/utils/router.dart';
import 'package:path/path.dart';

class LogInProvider extends ChangeNotifier {
  bool _obscurePassword;

  String _password;
  String _enteredPassword;
  String _newPassword;

  String _description;

  bool _firstLogin;
  bool _isChangePassword;

  LocalData _localData = LocalData();

  Icon _obscurePasswordIcon;

  final BuildContext context;

  LogInProvider({this.context}) {
    _obscurePassword = true;

    _obscurePasswordIcon = Icon(Icons.visibility_off);

    _init();
  }

  void _init() async {
    _password = await _localData.getUserPin();

    _isChangePassword = false;

    //Caso já exista uma senha cadastrada
    if (_password != null) {
      _description = "Insira o PIN ou entre com a digital";
      _firstLogin = false;

    } else {
      _description = "Por favor cadastre um PIN";
      _firstLogin = true;
    }

    notifyListeners();
  }

  //Altera visibilidade do campo de senha
  Future<void> toggleObscurePassword() async {

    _obscurePassword ^= true;

    if (_obscurePassword == true) {
      _obscurePasswordIcon = Icon(Icons.visibility_off);
    } else {
      _obscurePasswordIcon = Icon(Icons.visibility);
    }
    notifyListeners();
  }

  void biometricsLogin() async {

    //Verifica digital apenas se já houver uma senha cadastrada
    LocalAuthentication localAuth = LocalAuthentication();
    List<BiometricType> availableBiometrics =  await localAuth.getAvailableBiometrics();

    if (availableBiometrics.contains(BiometricType.fingerprint)) {
      try {
        var localAuth = new LocalAuthentication();

        bool didAuthenticate = await localAuth.authenticateWithBiometrics(
            localizedReason: 'Please authenticate yourself',
            useErrorDialogs: false);

        if (didAuthenticate) {
          print('Autenticado');
          Navigator.pushReplacementNamed(context, homeRoute);
        } else {
          print('Não autenticado');
          _description = "Digital não reconhecida";
          notifyListeners();
        }
      }
      catch (e) 
      {
        print(e.toString());
      }
    }
  }

  Future<bool> submitLogIn() async {

    //Caso não exista uma senha cadastrada
    //Salva a senha inserida
    if (_password == null) {

      if(_enteredPassword.isNotEmpty)
      {
        _localData.saveUserPin(_enteredPassword);
        _description = "Senha cadastrada com sucesso";
        notifyListeners();

        Future.delayed(Duration(milliseconds: 1000));
        Navigator.pushReplacementNamed(context, homeRoute);
      }
      else
      {
        _description = "Senha não pode ser nula";
        notifyListeners();
        return false;
      }
    }

    //Caso já exista uma senha, verifica se está correta
    else {
      
      //Caso a senha seja válida, reliza a navegação para Home
      if (_password == _enteredPassword) {
        Navigator.pushReplacementNamed(context, homeRoute);
      }

      //Caso a senha esteja incorreta, altera texto para notificar o usuário
      else {
        _description = "Senha incorreta";
        notifyListeners();
        return false;
      }
    }
  }

  Future<bool> authenticateUser() async {
    //Verifica digital apenas se já houver uma senha cadastrada
    LocalAuthentication localAuth = LocalAuthentication();
    List<BiometricType> availableBiometrics =  await localAuth.getAvailableBiometrics();

    if (availableBiometrics.contains(BiometricType.fingerprint)) {
      try {
        var localAuth = new LocalAuthentication();

        bool didAuthenticate = await localAuth.authenticateWithBiometrics(
            localizedReason: 'Please authenticate yourself',
            useErrorDialogs: false);

        return didAuthenticate;
      }
      catch (e) 
      {
        print(e.toString());
      }
    }

    return false;
  }

  bool changePassword(bool isAuth, bool submitChange)
  {
    if(isAuth)
    {
      _description = "Insira nova senha";
      _isChangePassword = true;
      notifyListeners();
    }

    if(submitChange)
    {
      if(_enteredPassword.isNotEmpty)
      {
        _localData.saveUserPin(_enteredPassword);
        _description = "Senha cadastrada com sucesso";
        notifyListeners();

        Future.delayed(Duration(milliseconds: 1000));
        Navigator.pushReplacementNamed(context, homeRoute);
      }
      else
      {
        _description = "Senha não pode ser nula";
        notifyListeners();
        return false;
      }
    }
    
    return true;
  }

  bool get obscurePassword => _obscurePassword;
  Icon get obscurePasswordIcon => _obscurePasswordIcon;

  String get password => _enteredPassword;
  void set password(String password) => _enteredPassword = password;

  String get newPassword => _newPassword;
  void set newPassword(String password) => _newPassword = password;

  String get desciption => _description;

  bool get firstLogin => _firstLogin;

  bool get isChangePassword => _isChangePassword;
}
