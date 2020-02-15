
import 'package:flutter/cupertino.dart';
import 'package:minerva_investimentos/models/asset_model.dart';
import 'package:minerva_investimentos/providers/asset_provider.dart';
import 'package:minerva_investimentos/widgets/homeCard.dart';

class HomeProvider extends ChangeNotifier
{
  final AssetProvider assetProvider;

  String _enteredAsset;

  //TODO: implementar lógica da lista de ativos
  List<B3Asset> _b3AssetList = List<B3Asset>();

  List<HomeCardWidget> _homeCardList = List<HomeCardWidget>();
  int _homeCardListLength;

  HomeProvider({this.assetProvider})
  {
    _homeCardList.add( HomeCardWidget(
                      ativo: Text("TGAR11"),
                      cotacao: Text("12,50"),
                      dividendo: Text("0,50")));
     _homeCardList.add( HomeCardWidget(
                      ativo: Text("TGAR11"),
                      cotacao: Text("12,50"),
                      dividendo: Text("0,50")));
      _homeCardListLength = 2;
  }

  //Adiciona o ativo escolhida a lista de ativos
  void submitAsset()
  {
   print(_enteredAsset); 
   _homeCardList.add( HomeCardWidget(
                      ativo: Text(_enteredAsset),
                      cotacao: Text("12,50"),
                      dividendo: Text("0,50")));
    _homeCardListLength = _homeCardList.length;
  notifyListeners();
  }

   String get enteredAsset => _enteredAsset;
   void set enteredAsset(String asset)=> _enteredAsset = asset;

   List<HomeCardWidget> get homeCardWidgetList => _homeCardList;
   int get homeCardListLength => _homeCardListLength;
}