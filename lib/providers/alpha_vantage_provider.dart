

import 'dart:convert';

import 'package:minerva_investimentos/data/marked_data.dart';
import 'package:minerva_investimentos/models/alpha_vantage_model.dart';

class AplhaVantageProvider
{
  MarketData _marketData = MarketData();

  Future<AlphaVantageDaily> getAlphaVantageDaily(String ticker) async
  {
    String response = await _marketData.alphaVantageDaily(ticker);
    
    var decodedJson = json.decode(response);

    AlphaVantageDaily alphaVantageDaily = AlphaVantageDaily.fromJson(decodedJson);

    return alphaVantageDaily;
  }

  Future<AlphaVantageIntraDay> getAlphaVantageIntraDay(String ticker) async
  {
    String response = await _marketData.alphaVantageIntraDay(ticker);
    
    var decodedJson = json.decode(response);

    AlphaVantageIntraDay alphaVantageIntraDay = AlphaVantageIntraDay.fromJson(decodedJson);

    return alphaVantageIntraDay;
  }

}