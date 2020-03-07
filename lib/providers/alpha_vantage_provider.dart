

import 'dart:convert';

import 'package:minerva_investimentos/data/marked_data.dart';
import 'package:minerva_investimentos/models/alpha_vantage_model.dart';

class AlphaVantageProvider
{
  MarketData _marketData = MarketData();

  Future<AlphaVantageDaily> _getAlphaVantageDaily(String ticker) async
  {
    String response = await _marketData.alphaVantageDaily(ticker);
    
    var decodedJson = json.decode(response);

    AlphaVantageDaily alphaVantageDaily = AlphaVantageDaily.fromJson(decodedJson);

    return alphaVantageDaily;
  }

  Future<AlphaVantageIntraDay> _getAlphaVantageIntraDay(String ticker) async
  {
    String response = await _marketData.alphaVantageIntraDay(ticker);
    
    var decodedJson = json.decode(response);

    AlphaVantageIntraDay alphaVantageIntraDay = AlphaVantageIntraDay.fromJson(decodedJson);

    return alphaVantageIntraDay;
  }

  Future<AlphaVantageDate> getAlphaVantageDay(String ticker, String date) async
  {
    
    //Converter 01/02/2020 --> 20202-02-01
    String _dataDate = date.substring(6, 10)+"-"+
                       date.substring(3, 5)+"-"+
                       date.substring(0, 2);

    String response = await _marketData.alphaVantageDaily(ticker);
    
    var decodedJson = json.decode(response);

    AlphaVantageDate alphaVantageDate = AlphaVantageDate.fromJson(decodedJson, _dataDate);

    return alphaVantageDate;
  }

  Future<List<AlphaVantageDaily>> getAlphaVantageDailyList(List<String> tickerList) async
  {
    List<AlphaVantageDaily> alphaVantageDailyList = List<AlphaVantageDaily>();

    for (String ticker in tickerList) 
    {
      AlphaVantageDaily response = await _getAlphaVantageDaily(ticker);
      alphaVantageDailyList.add(response);
    }

    return alphaVantageDailyList;    
  }


  Future<List<AlphaVantageIntraDay>> getAlphaVantageIntraDayList(List<String> tickerList) async
  {
    List<AlphaVantageIntraDay> alphaVantageIntraDayList = List<AlphaVantageIntraDay>();

    for (String ticker in tickerList) 
    {
      AlphaVantageIntraDay response = await _getAlphaVantageIntraDay(ticker);
      alphaVantageIntraDayList.add(response);
    }

    return alphaVantageIntraDayList;    
  }

}