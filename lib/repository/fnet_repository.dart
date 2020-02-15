import 'package:minerva_investimentos/data/B3_data.dart';
import 'package:minerva_investimentos/models/asset_model.dart';
import 'package:minerva_investimentos/models/fnet_model.dart';
import 'package:minerva_investimentos/utils/functions.dart';


class FnetRepository
{

  ///Acessa os respectivos documentos da FNET e recupera a lsita de dados FNET
  Future<FNET> fnetList() async
  {
    Functions functions = Functions();
    B3Data b3 = B3Data();

    //Acessa site FNET e recupera corpo do HTML
    String response = await b3.fetchFnetDocument("dummy");

    //Aplica regex no HTML e recupera lista de Assets
    FNET a = functions.regexFnetList(response);                  

    print(a.infoDate); 
    print(a.baseDate); 
    print(a.paymentDate); 
    print(a.dividend.toString()); 
    print(a.referenceDate);
    print(a.year);
  }

}