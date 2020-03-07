




import 'package:minerva_investimentos/models/asset_model.dart';
import 'package:minerva_investimentos/models/fnet_model.dart';
import 'package:minerva_investimentos/models/investing_model.dart';

class Functions
{
  ///Recebe uma string e aplica ReGex para procurar a lista de Fii
  ///Retorna lista de Assets
  List<B3Asset> regexAssetList(String data) 
  {
    List<B3Asset> assetList = List<B3Asset>();
  
    //Define ReGex a ser utilizado para recuperar o ticker
    RegExp regexTicker = RegExp(
      "_lblSigla\">(.+)<\/span><\/td>"
    );
     
    //Define ReGex a ser utilizado para recuperar o nome e o fundo do asset
    RegExp regexNameFund = RegExp(
      "aba=abaPrincipal\">(.+)<\/a>"
    );

    List<RegExpMatch> nomeFundo = regexNameFund.allMatches(data).toList();
    int i = 0;
    
    for (RegExpMatch ticker in regexTicker.allMatches(data).toList()) {
      B3Asset asset = B3Asset();

      asset.ticker = ticker.group(1);
      asset.name = nomeFundo[i].group(1);
      asset.fund = nomeFundo[i+1].group(1);

      i+= 2; //Incremento de +2 pq o segundo regex revolve as duas informações concomitantemente
      assetList.add(asset);
    }

    return assetList;

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

  InvestingDayValue regexInvestingDate(String data)
  {
    InvestingDayValue investingDayValue = InvestingDayValue();

    //Define ReGex a ser utilizado para recuperar as informações do arquivo FNET
    RegExp regexFnet = RegExp(
      ">(.+)<\/td>"
    );
    
    List<String> a = List<String>();

    List<RegExpMatch> regexData = regexFnet.allMatches(data).toList(); 

    investingDayValue.date =  regexData[0].group(1);
    investingDayValue.price =  regexData[1].group(1);
    investingDayValue.open =  regexData[2].group(1);
    investingDayValue.high =  regexData[3].group(1);
    investingDayValue.low =  regexData[4].group(1);
      
    return investingDayValue;
  }
  
}