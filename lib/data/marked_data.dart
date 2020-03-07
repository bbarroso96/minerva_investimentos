import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minerva_investimentos/models/alpha_vantage_model.dart';
import 'package:minerva_investimentos/models/asset_model.dart';

class MarketData
{
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

    Future<String> alphaVantageIntraDay(String ticker, ) async
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