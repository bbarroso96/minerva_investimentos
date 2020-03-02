import 'package:minerva_investimentos/data/B3_data.dart';
import 'package:minerva_investimentos/models/asset_model.dart';
import 'package:minerva_investimentos/models/fnet_model.dart';
import 'package:minerva_investimentos/utils/functions.dart';


class FnetRepository
{

  ///Acessa os respectivos documentos da FNET e recupera a lsita de dados FNET
  Future<List<FNET>> fnetList(List<String> assetList) async
  {
    Functions functions = Functions();
    B3Data b3 = B3Data();
    List<FNET> fnetList = List<FNET>();

    //Itera a lista de ativos para acessar o respectivo site e
    //recuperar o respectivo documendo com as informações dos dividendos
    for (String asset in assetList)
    {
      String dummyUrl = "http://fnet.bmfbovespa.com.br/fnet/publico/exibirDocumento?id=79225";

      //Acessa site FNET e recupera corpo do HTML
      String response = await b3.fetchFnetDocument(dummyUrl);

      //Aplica regex no HTML e recupera lista de Assets
      FNET a = functions.regexFnetList(response);  
      a.ticker = asset;                

      print(a.infoDate); 
      print(a.baseDate); 
      print(a.paymentDate); 
      print(a.dividend.toString()); 
      print(a.referenceDate);
      print(a.year);
      print(a.ticker);

      fnetList.add(a);
    }

    return fnetList;
    
  }

}