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
      List<String> _urls = await getAssetDocumentUrl(asset);

      String response;

      for (String url in _urls) 
      {
         //Acessa site FNET e recupera corpo do HTML
        response = await b3.fetchFnetDocument(url);

        //Verifica se o ativo do documento está correto
        //Pode ser o XPTO3 etc
        //Queremos XPTO11
        bool isValid = response.contains(asset+"11");  

        //Caso seja o documento certo, sai do loop
        if(isValid) {break;}
      }

      //TODO: validar se foi possível recuperar documento

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

  Future<List<String>> getAssetDocumentUrl(String asset) async
  {
    B3Data b3 = B3Data();
  
    String response = await b3.fetchFundExplorerData(asset); 

    List<String> a = response.split("Aviso aos Cotistas");

    List<String> b = List<String>();
    
    for (String c in a) 
    {
      String d = c.substring(c.lastIndexOf("href=\"")+6, c.lastIndexOf("\">"));

      d = d.replaceFirst("https", "http");

      print(d);

      b.add(d);
    }
  

    return b;
  }

}