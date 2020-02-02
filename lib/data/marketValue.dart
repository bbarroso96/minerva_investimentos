import 'package:http/http.dart' as http;

class MarketValue{

  Future<http.Response> fetchPost(String url) {
    return http.get(url);
  }


}