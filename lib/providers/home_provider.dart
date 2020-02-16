
import 'package:flutter/cupertino.dart';
import 'package:minerva_investimentos/data/db_data.dart';
import 'package:minerva_investimentos/models/asset_model.dart';
import 'package:minerva_investimentos/providers/asset_provider.dart';
import 'package:minerva_investimentos/providers/portfolio_provider.dart';
import 'package:minerva_investimentos/widgets/homeCard.dart';

class HomeProvider extends ChangeNotifier
{
  final AssetProvider assetProvider;
  PortfolioProvider portfolioProvider = PortfolioProvider();
  List<PortfolioAsset> _portfolioList = List<PortfolioAsset>();

  String _enteredAsset;

  //TODO: implementar lógica da lista de ativos
  List<B3Asset> _b3AssetList = List<B3Asset>();

  List<HomeCardWidget> _homeCardList = List<HomeCardWidget>();
  int _homeCardListLength = 0;

  HomeProvider({this.assetProvider})
  {
    _init();
  }

  void _init() async
  {
    //Recupera portifólio
    _portfolioList = await portfolioProvider.getPortfolio();

    //Popula a lista de ativos da home
    for (PortfolioAsset asset in _portfolioList)
    {
     _homeCardList.add( HomeCardWidget(
                      ativo: Text(asset.ticker),
                      cotacao: Text(asset.amount.toString()),
                      dividendo: Text(asset.amount.toString())));
    }
    _homeCardListLength = _homeCardList.length;
    notifyListeners();
  }

  //Adiciona o ativo escolhida a lista de ativos
  void submitAsset() async
  {
   print(_enteredAsset); 
   _homeCardList.add( HomeCardWidget(
                      ativo: Text(_enteredAsset),
                      cotacao: Text("12,50"),
                      dividendo: Text("0,50")));
    _homeCardListLength = _homeCardList.length;
    notifyListeners();

    //Adiciona o ativo ao portifólio
    PortfolioAsset portfolioAsset = PortfolioAsset();
    portfolioAsset.ticker = _enteredAsset;
    portfolioAsset.amount = _homeCardList.length;
    portfolioProvider.addToPortfolio(portfolioAsset);
  }

  void removeAsset(String ticker)
  {
    
    portfolioProvider.removeAssetFromPorfolio(ticker);
  }

   String get enteredAsset => _enteredAsset;
   void set enteredAsset(String asset)=> _enteredAsset = asset;

   List<HomeCardWidget> get homeCardWidgetList => _homeCardList;
   int get homeCardListLength => _homeCardListLength;
}