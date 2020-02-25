import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:minerva_investimentos/data/B3_data.dart';
import 'package:minerva_investimentos/data/marketValue.dart';
import 'package:minerva_investimentos/providers/log_in_provider.dart';
import 'package:minerva_investimentos/repository/asset_repository.dart';
import 'package:minerva_investimentos/repository/fnet_repository.dart';
import 'package:minerva_investimentos/utils/router.dart';
import 'package:provider/provider.dart';

class LogInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LogInProvider>(
      create: (_) => LogInProvider(context: context),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          )),
          child: Consumer<LogInProvider>(builder: (context, provider, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //Usado apenas como widget 1 de 3 para alinhamento
                SizedBox(),

                //Formulário de PIN
                Padding(
                  child: TextFormField(
                    keyboardType: TextInputType.number,

                    obscureText: provider.obscurePassword,

                    decoration: InputDecoration(
                      counter: GestureDetector(
                          child: provider.obscurePasswordIcon,
                          onTap: () => provider.toggleObscurePassword()),
                      helperText: provider.desciption,
                    ),

                    //autofocus: true,             //Define o campo como selecionado por default
                    autovalidate: true, //Define autovalidação
                    validator: (String password) {
                      provider.password = password;
                    },

                    onFieldSubmitted: (_) async {
                      //TODO: tirar market value daqui
                      //MarketValue ma = MarketValue();
                      //Response response = await ma.intradayValue("TGAR11");
                      //print(response.body.toString());

                      /*
                        AssetRepository a = AssetRepository();
                        var b = a.listaAssets();

                        FnetRepository c = FnetRepository();
                        var d = c.fnetList();
                        */
                      
                      if(provider.isChangePassword)
                      {
                        provider.changePassword(false, true);
                      }
                      else
                      {
                        provider.submitLogIn();
                      }

                      //provider.toggleObscurePassword();
                      //Navigator.pushReplacementNamed(context, homeRoute);
                    },
                  ),
                  padding: EdgeInsets.all(50.0),
                ),

                //Row para opções de entrada
                //Entrar com digital, alterar senha
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        child: Text('Alterar senha'),
                        onPressed: provider.firstLogin == true ? null : 
                          () async {  
                            bool auth = await provider.authenticateUser(); 
                            provider.changePassword(auth, false);       
                          },
                      ),

                      FlatButton(
                        child: Text('Entrar com digital'),
                        onPressed: provider.firstLogin == true ? null : () {provider.biometricsLogin();},
                      ),
                    ])
              ],
            );
          }),
        ),
      ),
    );
  }


 

}
