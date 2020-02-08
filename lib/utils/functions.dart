




import 'package:minerva_investimentos/models/asset_model.dart';
import 'package:minerva_investimentos/models/fnet_model.dart';

class Functions
{
  ///Recebe uma string e aplica ReGex para procurar a lista de Fii
  ///Retorna lista de Assets
  List<Asset> regexAssetList(String dado) 
  {
    List<Asset> listaAsset = List<Asset>();
  
    //Define ReGex a ser utilizado para recuperar o ticker
    RegExp regexTicker = RegExp(
      "_lblSigla\">(.+)<\/span><\/td>"
    );
     
    //Define ReGex a ser utilizado para recuperar o nome e o fundo do asset
    RegExp regexNameFund = RegExp(
      "aba=abaPrincipal\">(.+)<\/a>"
    );

    List<RegExpMatch> nomeFundo = regexNameFund.allMatches(dado).toList();
    int i = 0;
    
    for (RegExpMatch ticker in regexTicker.allMatches(dado).toList()) {
      Asset asset = Asset();

      asset.ticker = ticker.group(1);
      asset.nome = nomeFundo[i].group(1);
      asset.fundo = nomeFundo[i+1].group(1);

      i+= 2; //Incremento de +2 pq o segundo regex revolve as duas informações concomitantemente
      listaAsset.add(asset);
    }

    return listaAsset;

  }

  ///Recebe uma string e aplica ReGex para procurar a informações no documento de dividendos
  ///Retorna uma lista de objetos FNET
  FNET regexFnetList(String data)
  {

    FNET fnet = FNET();

    //Define ReGex a ser utilizado para recuperar as informações do arquivo FNET
    RegExp regexFnet = RegExp(
      "<\/td><td><span class=\"dado-valores\">(.+)<\/span><\/td><td>"
    );
    
     List<RegExpMatch> fnetData = regexFnet.allMatches(data).toList(); 

    //Converte regex para objeto FNET
    fnet.infoDate = fnetData[0].group(1);
    fnet.baseDate = fnetData[1].group(1);
    fnet.paymentDate = fnetData[2].group(1);    
    fnet.dividend = double.parse(fnetData[3].group(1).replaceAll(",", "."));  
    fnet.referenceDate = fnetData[4].group(1);
    fnet.year =  fnetData[5].group(1);

    return fnet;
  }
  
}