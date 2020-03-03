
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minerva_investimentos/data/db_data.dart';
import 'package:minerva_investimentos/models/asset_model.dart';
import 'package:minerva_investimentos/models/fnet_model.dart';
import 'package:minerva_investimentos/providers/asset_provider.dart';
import 'package:minerva_investimentos/providers/portfolio_provider.dart';
import 'package:minerva_investimentos/repository/fnet_repository.dart';
import 'package:minerva_investimentos/widgets/homeCard.dart';

class HomeProvider extends ChangeNotifier
{
  final AssetProvider assetProvider;
  final BuildContext context;

  PortfolioProvider portfolioProvider = PortfolioProvider();
  List<PortfolioAsset> _portfolioList = List<PortfolioAsset>();
  double _totalEarnings = 0;

  FnetRepository _fnetRepository = FnetRepository();
  List<FNET> _fnetList = List<FNET>();

  String _enteredAsset;
  String _enteredAmount;

  //TODO: implementar lógica da lista de ativos
  List<B3Asset> _b3AssetList = List<B3Asset>();

  List<HomeCardWidget> _homeCardList = List<HomeCardWidget>();
  int _homeCardListLength = 0;

  HomeProvider({this.assetProvider, this.context})
  {
    _init();
  }

  void _init() async
  {
    //Recupera portifólio
    _portfolioList = await portfolioProvider.getPortfolio();

    //Recupera dados dos dividendos diretamente do site
    //TODO: implemenetar chek no bd, toda a logica pra não iir na url sem necessidade, etc
    List<String> porfolioAssetLIst = List.from(_portfolioList.map((f) => f.ticker));
    _fnetList = await _fnetRepository.fnetList( porfolioAssetLIst );

    //Popula a lista de ativos da home
    int i = 0;
    for (PortfolioAsset asset in _portfolioList)
    {
     _homeCardList.add(HomeCardWidget(portfolioAsset: asset, fnetData: _fnetList[i]));

       //Calcula o valor total dos dividendos
       _totalEarnings += asset.amount * _fnetList[i].dividend;

     i++;
    }

    _homeCardListLength = _homeCardList.length;

   

    notifyListeners();
  }

  //TODO: atualizar o valor total dos dividendos com o add, edit, exclui, etc;


  //Adiciona o ativo escolhida a lista de ativos
  Future<String> submitAsset() async
  {
    print('Submit asset: ');
    print(_enteredAsset); 
    print(_enteredAmount);

    var isValid = await _validadeSubmitAsset();
    
    if(isValid != "OK") {return isValid;}

    //Constroi o ativo novo
    PortfolioAsset portfolioAsset = PortfolioAsset();
    portfolioAsset.ticker = _enteredAsset;
    portfolioAsset.amount = int.parse(_enteredAmount);
    _portfolioList.add(portfolioAsset);

    //Adicona a lista de ativos da home
    FNET _fnetTemp = FNET();
    _fnetTemp.dividend = 0.0;
    _homeCardList.add( HomeCardWidget(portfolioAsset: portfolioAsset, fnetData: _fnetTemp,));
    _homeCardListLength = _homeCardList.length;
    notifyListeners();

    //Adiciona o ativo ao portifólio
    portfolioProvider.addToPortfolio(portfolioAsset);

    //Redundandte passar "_enteredAsset"
    updateFnet([_enteredAsset]);

    return isValid;
  }

  void updateFnet(List<String> asset) async
  {
    List<FNET> _fnetUpdate = await _fnetRepository.fnetList(asset);

    int i = 0;
    for (FNET fnet in _fnetUpdate)
    {
     
      HomeCardWidget card = _homeCardList.firstWhere( (f) => f.portfolioAsset.ticker == asset[i] );
      
      int editIndex = _homeCardList.indexWhere( (f) => f.portfolioAsset.ticker == asset[i] );

      PortfolioAsset cardPortfolioAsset = card.portfolioAsset;
      
      _homeCardList[editIndex] = HomeCardWidget(portfolioAsset: cardPortfolioAsset, fnetData:  fnet,);

      _totalEarnings += cardPortfolioAsset.amount * fnet.dividend;

      notifyListeners();

     i++;
    }
  }

  //Valida inserção do ativo no portifolio
  Future<String> _validadeSubmitAsset() async
  {
    //Verifica se a quantidade não é nula
    if(_enteredAsset.isEmpty)
    {
      return "Ativo deve ser preenchido";
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

  void removeAsset(HomeCardWidget removeItem)
  {
    _homeCardList.remove(removeItem);
    _homeCardListLength = _homeCardList.length;

    _totalEarnings -= removeItem.portfolioAsset.amount * removeItem.fnetData.dividend;

    _portfolioList.remove(removeItem.portfolioAsset);

    notifyListeners();

    portfolioProvider.removeAssetFromPorfolio(removeItem.portfolioAsset.ticker);
  }

  void editAsset(int editIndex)
  {
    print('Edit asset: ');
    print(homeCardWidgetList[editIndex].portfolioAsset.ticker.toString()); 
    print(_enteredAmount);

    //Constroi o ativo novo
    PortfolioAsset portfolioAsset = PortfolioAsset();
    portfolioAsset.ticker = homeCardWidgetList[editIndex].portfolioAsset.ticker;
    portfolioAsset.amount = int.parse(_enteredAmount);

    //Recupera fnet
    FNET cardFnet = _homeCardList[editIndex].fnetData;
    PortfolioAsset cardPortfolioAsset = _homeCardList[editIndex].portfolioAsset;

    _homeCardList[editIndex] = HomeCardWidget(portfolioAsset: portfolioAsset, fnetData: cardFnet);

    _portfolioList[editIndex] = portfolioAsset;

    //Novo - Antigo
    _totalEarnings += ( (portfolioAsset.amount * cardFnet.dividend) - (cardPortfolioAsset.amount * cardFnet.dividend));
    notifyListeners();

    portfolioProvider.editAssetFromPorfolio(portfolioAsset);
  }

   String get enteredAsset => _enteredAsset;
   void set enteredAsset(String asset)=> _enteredAsset = asset;

   String get enteredAmount => _enteredAmount;
   void set enteredAmount(String amount)=> _enteredAmount = amount;

   List<HomeCardWidget> get homeCardWidgetList => _homeCardList;
   int get homeCardListLength => _homeCardListLength;

   double get totalEarnings => _totalEarnings;
}