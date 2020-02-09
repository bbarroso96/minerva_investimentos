import 'package:shared_preferences/shared_preferences.dart';

///Classe para tratar os dados locais do usuário
class LocalData
{
  final passwordKey = 'password';

  ///Armazena a senha
  void saveUserPin(String password) async
  {
    try
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(passwordKey, password);
    }
    catch(e)
    {
      print(e.toString());
      throw Exception(e);
    }
  }

  ///Recupera a senha do usuário
  Future<String> getUserPin() async
  {
    try
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String password = prefs.getString(passwordKey);

      return password;
    }
    catch(e)
    {
      print(e.toString());
      throw Exception(e);
    }

  }

  void deleteUserPin() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(passwordKey);
  }


}