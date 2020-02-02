import 'package:http/http.dart' as http;

class MarketValue{

  //TODO: preencher com a chave
  String _apiKey = "";

  Future<http.Response> intradayValue(String ativo) {
    
    //TODO: descomentar url de valor do ativo para uso final
    //String _url = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=" + ativo + "&interval=5min&apikey=" + _apiKey;
    String _url = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=5min&apikey=demo";

    return http.get(_url);
  }


}