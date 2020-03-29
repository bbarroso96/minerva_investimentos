
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minerva_investimentos/data/db_data.dart';
import 'package:minerva_investimentos/data/marked_data.dart';
import 'package:minerva_investimentos/models/alpha_vantage_model.dart';
import 'package:minerva_investimentos/models/asset_model.dart';
import 'package:minerva_investimentos/models/fnet_model.dart';
import 'package:minerva_investimentos/models/investing_model.dart';
import 'package:minerva_investimentos/providers/alpha_vantage_provider.dart';
import 'package:minerva_investimentos/providers/asset_provider.dart';
import 'package:minerva_investimentos/providers/investing_provider.dart';
import 'package:minerva_investimentos/providers/portfolio_provider.dart';
import 'package:minerva_investimentos/repository/fnet_repository.dart';
import 'package:minerva_investimentos/utils/functions.dart';
import 'package:minerva_investimentos/widgets/homeCard.dart';

class HomeProvider extends ChangeNotifier
{
  final AssetProvider assetProvider;
  final BuildContext context;
   AlphaVantageProvider aplhaVantageProvider =  AlphaVantageProvider();
   InvestingProvider investingProvider = InvestingProvider();

  PortfolioProvider portfolioProvider = PortfolioProvider();
  List<PortfolioAsset> _portfolioList = List<PortfolioAsset>();
  double _totalEarnings = 0;

  FnetRepository _fnetRepository = FnetRepository();
  List<FNET> _fnetList = List<FNET>();
  List<InvestingDayValue> _investingDayValueList = List<InvestingDayValue>();
  List<InvestingCurrentValue> _investingCurrentValueList = List<InvestingCurrentValue>();

  String _enteredAsset;
  String _enteredAmount;
  String _enteredAvPrc;

  //TODO: implementar lógica da lista de ativos
  List<B3Asset> _b3AssetList = List<B3Asset>();

  HomeProvider({this.assetProvider, this.context})
  {
    _init();
  }

  void _init() async
  {
    //Recupera portifólio
    _portfolioList = await portfolioProvider.getPortfolio();
    FNET fnetDummy = FNET();
    InvestingDayValue investingDayValueDummy = InvestingDayValue();
    InvestingCurrentValue investingCurrentValueDummy = InvestingCurrentValue();
    fnetDummy.dividend = 0.0;
    _fnetList = List.filled(_portfolioList.length, fnetDummy);
    _investingDayValueList = List.filled(_portfolioList.length, investingDayValueDummy);
    _investingCurrentValueList = List.filled(_portfolioList.length, investingCurrentValueDummy);
    notifyListeners();

    //Recupera dados dos dividendos diretamente do site
    //TODO: implemenetar chek no bd, toda a logica pra não iir na url sem necessidade, etc
    List<String> porfolioAssetLIst = List.from(_portfolioList.map((f) => f.ticker));
    _fnetList = await _fnetRepository.fnetList( porfolioAssetLIst );
    
    //Calcula o valor total dos dividendos
    int i = 0;
    for (PortfolioAsset asset in _portfolioList)
    {  
       _totalEarnings += asset.amount * _fnetList[i].dividend;
      i++;
    }   

    notifyListeners();




    //TODO:
    //Nem todas as datas estão disponíveis no alphaVantage
    //vai ter q pegar a mais proxima
    //var a = await aplhaVantageProvider.getAlphaVantageDay(_fnetList[0].ticker, _fnetList[0].baseDate);

   //List<AlphaVantageDaily> alphaVantageDailyList = await aplhaVantageProvider.getAlphaVantageDailyList(porfolioAssetLIst);
   //List<AlphaVantageIntraDay> alphaVantageIntraDayList = await aplhaVantageProvider.getAlphaVantageIntraDayList(porfolioAssetLIst);
  
    _investingDayValueList = await investingProvider.getInvestingDayValue(porfolioAssetLIst, _fnetList);
    notifyListeners();

    _investingCurrentValueList = await investingProvider.getInvestingCurrentValue(porfolioAssetLIst);
    notifyListeners();

  }

 

  //////////////////////////////////////////////////////////////////
  ///Adiciona o ativo escolhida a lista de ativos
  /////////////////////////////////////////////////////////////////
  Future<String> submitAsset() async
  {
    print('Submit asset: ');
    print(_enteredAsset); 
    print(_enteredAmount);
    print(_enteredAvPrc);

    //var isValid = await validadeSubmitAsset();
    
    //if(isValid != "OK") {return isValid;}

    //Constroi o ativo novo
    PortfolioAsset portfolioAsset = PortfolioAsset();
    portfolioAsset.ticker = _enteredAsset;
    portfolioAsset.amount = int.parse(_enteredAmount);
    portfolioAsset.averagePrice = double.parse(_enteredAvPrc);
    _portfolioList.add(portfolioAsset);

    //Adiciona um fnet vazio
    FNET fnet = FNET();
    fnet.dividend = 0.0;
    _fnetList.add(fnet);

    //Adiciona valores do ativo
    InvestingCurrentValue investingCurrentValue = InvestingCurrentValue();
    InvestingDayValue investingDayValue = InvestingDayValue();
    _investingCurrentValueList.add(investingCurrentValue);
    _investingDayValueList.add(investingDayValue);

    notifyListeners();

    //Adiciona o ativo ao portifólio
    portfolioProvider.addToPortfolio(portfolioAsset);

    //Redundandte passar "_enteredAsset"
    var a = await updateFnet([_enteredAsset]);

    //Atualiza o valor do ativo
    updateCurrentValue([_enteredAsset]);

    //Atualiza o valor do dia do dividendo
    //TODO: essa logica provavelmente vai morar dentro do fnet
    updateDayValue([_enteredAsset]);

    return "OK";
  }

  //////////////////////////////////////////////////////////////////
  ///Atualiza a lista de investingDayValue
  /////////////////////////////////////////////////////////////////
  Future<bool> updateDayValue(List<String> asset) async
  {
    //Recupera fnet por ativo
    List<FNET> _fnet = await _fnetRepository.fnetList(asset);

    //Recupera os valores do rendimendo do dia
    List<InvestingDayValue> _investingDayUpdate = await investingProvider.getInvestingDayValue(asset, _fnet);

    int i = 0;
    for (InvestingDayValue investingDay in _investingDayUpdate)
    {
      int updateIndex = _portfolioList.indexWhere((f) => f.ticker == asset[i]);

      _investingDayValueList[updateIndex] = investingDay;

      notifyListeners();

     i++;
    }
    return true;
  }


  Future<void> refreshValue() async
  {
    List<String> assetList = List<String>();

    _portfolioList.forEach((f)=> assetList.add(f.ticker));

    updateCurrentValue(assetList);
  }

  //////////////////////////////////////////////////////////////////
  ///Atualiza a lista de investingCurrentValue
  /////////////////////////////////////////////////////////////////
  void updateCurrentValue(List<String> asset) async
  {
    //Recupera os valores do rendimendo do dia
    List<InvestingCurrentValue> _investingurrentUpdate = await investingProvider.getInvestingCurrentValue(asset);

    int i = 0;
    for (InvestingCurrentValue investingCurrent in _investingurrentUpdate)
    {
      int updateIndex = _portfolioList.indexWhere((f) => f.ticker == asset[i]);

      _investingCurrentValueList[updateIndex] = investingCurrent;

      notifyListeners();

     i++;
    }
  }

  //////////////////////////////////////////////////////////////////
  ///Atualiza a lista de FNET
  /////////////////////////////////////////////////////////////////
  void updateFnet(List<String> asset) async
  {
    //Recupera os dividendos por ativo
    List<FNET> _fnetUpdate = await _fnetRepository.fnetList(asset);

    //Itera os dividendos para atualizar o valor total
    int i = 0;
    for (FNET fnet in _fnetUpdate)
    {    
      int updateIndex = _portfolioList.indexWhere((f) => f.ticker == asset[i]);

      _fnetList[updateIndex] = fnet;

      _totalEarnings += _portfolioList[updateIndex].amount * fnet.dividend;

      notifyListeners();

     i++;
    }
  }

  //////////////////////////////////////////////////////////////////
  ///Valida inserção do ativo no portifolio
  /////////////////////////////////////////////////////////////////
  Future<String> validadeSubmitAsset() async
  {
    //Verifica se a quantidade não é nula
    if(_enteredAsset.isEmpty)
    {
      return "Ativo deve ser preenchido";
    }

    //Verifica se preço médio não é nulo
    if(_enteredAvPrc.isEmpty)
    {
      return "Preço médio deve ser preenchido";
    }

    //Verifica se a quantidade não é nula
    if(_enteredAmount.isEmpty)
    {
      return "Quantidade deve ser preenchida";
    }

    //Verifica se o ativo possui 4 caracteres
    if(_enteredAsset.length != 4)
    {
      return "Ativo deve conter 4 caracteres";
    }

    //Verifica se o ativo já não existe no portfolio
    PortfolioAsset portfolioTest = _portfolioList.firstWhere((portfolioTest) => portfolioTest.ticker == _enteredAsset,
                                                              orElse: () => null);
    if(portfolioTest != null)
    {
      return "Ativo já existe na carteira";
    }

    //Verifica se o ativo inserido é válido
    //Deve ser um ativo da lista de ativos recuperados do site da B3
    var assetList = await assetProvider.getAssetList();
    if(!assetList.contains(_enteredAsset))  
    {
      return "Ativo inválido";
    }

    //Caso não exista erro, retorna string vazia
    return "OK";

  }

  //////////////////////////////////////////////////////////////////
  ///Remove ativo
  /////////////////////////////////////////////////////////////////
  void removeAsset(int removeIndex)
  {
    //Atualiza o valor total dos dividendos
    _totalEarnings -= _portfolioList[removeIndex].amount * _fnetList[removeIndex].dividend;

    portfolioProvider.removeAssetFromPorfolio(_portfolioList[removeIndex].ticker);

    //Atualiza a lista de portifolio
    _portfolioList.remove(_portfolioList[removeIndex]);

    //Atualiza a lista de fnet
    _fnetList.remove(_fnetList[removeIndex]);

    //Atualiza a lista de investingDay
    _investingDayValueList.remove(_investingDayValueList[removeIndex]);

    //Atualiza a lista de investingValue
    _investingCurrentValueList.remove(_investingCurrentValueList[removeIndex]);

    notifyListeners();
  }

  //////////////////////////////////////////////////////////////////
  ///Edita Ativo
  /////////////////////////////////////////////////////////////////
  void editAsset(int editIndex)
  {
    print('Edit asset: ');
    print(_enteredAmount);

    //Novo - Antigo
    _totalEarnings += ( (int.parse(_enteredAmount) - _portfolioList[editIndex].amount)  * _fnetList[editIndex].dividend ) ;

    //Atualiza PM 
    _portfolioList[editIndex].averagePrice = double.parse(_enteredAvPrc);

    //Atualiza qtd
    _portfolioList[editIndex].amount = int.parse(_enteredAmount);

    notifyListeners();

    //Edita ativo no bd
    portfolioProvider.editAssetFromPorfolio(_portfolioList[editIndex]);
  }

  //////////////////////////////////////////////////////////////////
  ///Get e set
  /////////////////////////////////////////////////////////////////
   String get enteredAsset => _enteredAsset;
   void set enteredAsset(String asset)=> _enteredAsset = asset;

   String get enteredAmount => _enteredAmount;
   void set enteredAmount(String amount)=> _enteredAmount = amount;

   String get enteredAvPrc => _enteredAvPrc;
   void set enteredAvPrc(String avPrc)=> _enteredAvPrc = avPrc;


   List<PortfolioAsset> get portfolioList => _portfolioList;

   List<FNET> get fnetList => _fnetList;

   List<InvestingDayValue> get investingDayValue => _investingDayValueList;

   List<InvestingCurrentValue> get investingCurrentValue => _investingCurrentValueList;

   double get totalEarnings => _totalEarnings;
}