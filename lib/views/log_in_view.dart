import 'package:flutter/material.dart';
import 'package:minerva_investimentos/utils/router.dart';

class LogInView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                {
                  Navigator.pushReplacementNamed(context, homeRoute);
                },
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          padding: EdgeInsets.all(50.0),
        ),
      ),
    );
  }
}
