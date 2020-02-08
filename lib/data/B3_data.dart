import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minerva_investimentos/models/asset_model.dart';

class B3Data
{
  ///Acessa o site da Bovespa e retorna a resposta
  Future<String> acessaListaFiiBovespa() async 
  {
    try
    {
      String _url = "http://bvmf.bmfbovespa.com.br/Fundos-Listados/FundosListados.aspx?tipoFundo=imobiliario&Idioma=pt-br";

      http.Response response = await http.get(_url);

      return response.body;
    }
    catch(e)
    {
      print(e.toString());
      throw Exception(e);
    } 

  }



  

  Future<http.Response> recuperaArquivoFNET() async {
    
  try
  {
    //String _url = "http://www.b3.com.br/pt_br/produtos-e-servicos/negociacao/renda-variavel/fundos-de-investimentos/fii/fiis-listados/";
    String _url = "http://fnet.bmfbovespa.com.br/fnet/publico/exibirDocumento?id=79225";

    http.Response response = await http.get(_url);

    //Decodifica dados da base64 pata string
    String ecnodedBase64 =response.body.substring(1, (response.body.length -1));
    String decoded = utf8.decode(base64.decode(ecnodedBase64)); 
    
    printWrapped(decoded);

    RegExp regExp = RegExp(
      "<\/td><td><span class=\"dado-valores\">(.+)<\/span><\/td><td>"
    );
     
      print("REGEX");
      
      for (RegExpMatch item in regExp.allMatches(decoded).toList() ) {

          print(
            item.group(1)

          );

      }
     

    return http.get(_url);
  }
  catch(e)
  {
    print(e.toString());
  } 

  }



void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

}