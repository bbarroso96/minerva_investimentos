import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:minerva_investimentos/data/B3_data.dart';
import 'package:minerva_investimentos/data/marketValue.dart';
import 'package:minerva_investimentos/repository/asset_repository.dart';
import 'package:minerva_investimentos/repository/fnet_repository.dart';
import 'package:minerva_investimentos/utils/router.dart';

class LogInView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          )
        ),
        child: Center(
          child: Padding(
            child: Column(
              children: <Widget>[
                
                Text("Digite a senha"),

                TextFormField(
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: const InputDecoration(
                    helperText: "Ou insira a digital",
                  ),

                  //autofocus: true,             //Define o campo como selecionado por default
                  autovalidate: true,           //Define autovalidação 
                  validator: (String value)     //Recupera o valor do campo para inserir a lógica de validação
                  {
                    //if (value.trim().isEmpty) {
                    //  return 'Password is required';
                    //}
                    if(value == "123"){
                      return 'Ok';
                    }

                  },
                  
                  onFieldSubmitted: (_)
                  async {
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


                    


                  Navigator.pushReplacementNamed(context, homeRoute);
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            padding: EdgeInsets.all(50.0),
          ),
        ),
      ),
    );
  }
}
