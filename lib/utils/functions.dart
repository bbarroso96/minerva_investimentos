



import 'package:minerva_investimentos/models/asset_model.dart';

class Functions
{
  ///Recebe uma string e aplica ReGex para procurar a lista de Fii
  ///Retorna lista de Assets
  List<Asset> regexListaFii(String dado) 
  {
    List<Asset> listaAsset = List<Asset>();
  
    //Define ReGex a ser utilizado para recuperar o ticker
    RegExp reGexTicker = RegExp(
      "_lblSigla\">(.+)<\/span><\/td>"
    );
     
    //Define ReGex a ser utilizado para recuperar o nome e o fundo do asset
    RegExp reGexNomeFundo = RegExp(
      "aba=abaPrincipal\">(.+)<\/a>"
    );

    List<RegExpMatch> nomeFundo = reGexNomeFundo.allMatches(dado).toList();
    int i = 0;
    
    for (RegExpMatch ticker in reGexTicker.allMatches(dado).toList()) {
      Asset asset = Asset();

      asset.ticker = ticker.group(1);

      asset.nome = nomeFundo[i].group(1);

      asset.fundo = nomeFundo[i+1].group(1);

      i+= 2;

      listaAsset.add(asset);
    }

  
    return listaAsset;

  }

  
}