import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minerva_investimentos/models/alpha_vantage_model.dart';
import 'package:minerva_investimentos/models/asset_model.dart';

class MarketData
{

  Future<String> getInVestingDayValue() async
  {
    try
    {
      String _url = 'https://www.investing.com/instruments/HistoricalDataAjax';

      Map<String, String> headers = {
        "Content-type": " application/x-www-form-urlencoded",
        "X-Requested-With": "XMLHttpRequest"
        };
        
      //String _body = '{"title": "Hello", "body": "body text", "userId": 1}';

      var post = await http.post(_url, headers: headers, body: "curr_id=940960&smlID=1506460&header=MXRF11+Historical+Data&st_date=03%2F06%2F2020&end_date=03%2F06%2F2020&interval_sec=Daily&sort_col=date&sort_ord=DESC&action=historical_data");

      return post.body;
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