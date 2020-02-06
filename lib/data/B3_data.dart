import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class B3Data
{

  Future<http.Response> listaFii() async {
    
  try
  {
    //String _url = "http://www.b3.com.br/pt_br/produtos-e-servicos/negociacao/renda-variavel/fundos-de-investimentos/fii/fiis-listados/";
    String _url = "http://fnet.bmfbovespa.com.br/fnet/publico/exibirDocumento?id=79225";

    http.Response response = await http.get(_url);

    //Decodifica dados da base64 pata string
    String ecnodedBase64 =response.body.substring(1, (response.body.length -1));
    String decoded = utf8.decode(base64.decode(ecnodedBase64)); 
    
     printWrapped(decoded);
      
     

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