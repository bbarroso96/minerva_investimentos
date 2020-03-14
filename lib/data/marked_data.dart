import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minerva_investimentos/models/alpha_vantage_model.dart';
import 'package:minerva_investimentos/models/asset_model.dart';

class MarketData
{

  //Acessa o site do investing.com para recuuperar a "historial data" em uma data específica
  Future<String> getInvestingDayValue(String ticker, String day, String month, String year, String pairId) async
  {
    try
    {
      String _url = 'https://www.investing.com/instruments/HistoricalDataAjax';

      //Headers necessários
      Map<String, String> headers = {
        "Content-type": " application/x-www-form-urlencoded",
        "X-Requested-With": "XMLHttpRequest"
        };
        
      //String _body = '{"title": "Hello", "body": "body text", "userId": 1}';

      //Recupera a chave do ativo usada no site
     // String _pairId = await _getTickerId(ticker);

      var post = await http.post(_url, headers: headers, body: "curr_id="+pairId+"&smlID=1506460&header="+ticker.toUpperCase()+"11+Historical+Data&st_date="+month+"%2F"+day+"%2F"+year+"&end_date="+month+"%2F"+day+"%2F"+year+"&interval_sec=Daily&sort_col=date&sort_ord=DESC&action=historical_data");

      return post.body;
    }
    catch (e)
    {
      print(e.toString());
      throw Exception(e);
    }
  }

  //Acessa o site do investing.com para recuuperar a "historial data" em uma data específica
  Future<String> getInvestingCurrentValue(String ticker, String day, String month, String year, String pairId) async
  {
    try
    {
      String _url = 'https://www.investing.com/instruments/HistoricalDataAjax';

      //Headers necessários
      Map<String, String> headers = {
        "Content-type": " application/x-www-form-urlencoded",
        "X-Requested-With": "XMLHttpRequest"
        };
        
      //String _body = '{"title": "Hello", "body": "body text", "userId": 1}';

      //Recupera a chave do ativo usada no site
      //String _pairId = await _getTickerId(ticker);

      bool _isValid = false;

      http.Response post;

      //Busca o valor no último dia útil
      while(_isValid != true)
      {
        post = await http.post(_url, headers: headers, body: "curr_id="+pairId+"&smlID=1506460&header="+ticker.toUpperCase()+"11+Historical+Data&st_date="+month+"%2F"+day+"%2F"+year+"&end_date="+month+"%2F"+day+"%2F"+year+"&interval_sec=Daily&sort_col=date&sort_ord=DESC&action=historical_data");

        //Decrementa um dia para procurar um dia útil
        day = (int.parse(day) -1).toString();

        //Retorna post caso
        if(!post.body.contains("No results found")){_isValid = true;}
      }

      return post.body;
    }
    catch (e)
    {
      print(e.toString());
      throw Exception(e);
    }
  }


    //Acessa o investing.com em um ativo para recuperar a sua chave
    Future<String> getInvesingTickerId(String ticker)async
    {
      try
      {
        String _url = 'https://www.investing.com/search/service/searchTopBar';

        Map<String, String> headers = {
        "Content-type": " application/x-www-form-urlencoded",
        "X-Requested-With": "XMLHttpRequest"
        };
        
        String _body = "search_text="+ticker.toUpperCase()+"11";


        var post = await http.post(_url, headers: headers, body: _body);

        //Procutra pelo texto: "pairId":940960,
        //Seleciona o index do "pairId":
        //Seleciona o index da primeira virgula apos "pairId":
        String _startIndexPartern = 'pairId":';
        int _startIndex = post.body.indexOf(_startIndexPartern);
        String _endIndexPatern = ',';
        int _endIndex = post.body.indexOf(_endIndexPatern, _startIndex);

        String pairId = post.body.substring(_startIndex + _startIndexPartern.length, _endIndex );

        return pairId;

      }
      catch (e)
      {
        print(e.toString());
        throw Exception(e);
      }     
    }











  String _apiKey = 'NL3RUJSYPG798047';

  Future<String> alphaVantageDaily(String ticker, ) async
  {
    try
    {
      String _url = 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=' + ticker.toUpperCase() + '11.SAO&apikey=' + _apiKey;

      http.Response response = await http.get(_url);

      return response.body;
    }
    catch (e)
    {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<String> alphaVantageIntraDay(String ticker ) async
  {
    try
    {
      String _url = 'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=' + ticker.toUpperCase() + '11.SAO&&interval=5min&apikey=' + _apiKey;

      http.Response response = await http.get(_url);

      return response.body;
    }
    catch (e)
    {
      print(e.toString());
      throw Exception(e);
    }
  }


}