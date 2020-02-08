import 'package:http/http.dart';
import 'package:minerva_investimentos/data/B3_data.dart';
import 'package:minerva_investimentos/models/asset_model.dart';
import 'package:minerva_investimentos/utils/functions.dart';

///Bll do ativo
class AssetRepository
{

  ///Recupera lista de ativos
  Future<List<Asset>> listaAssets()  async {

    Functions functions = Functions();
    B3Data b3 = B3Data();

    //Acessa site b3 e recupera corpo do HTML
    String response = await b3.acessaListaFiiBovespa();

    //Aplica regex no HTML e recupera lista de Assets
    List<Asset> a = functions.regexListaFii(response);                  

    for (Asset ativo in a) 
    {
      print(ativo.ticker+"  "+ativo.nome+"  "+ativo.fundo); 
    }
    
  }
  

}