
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

  HomeProvider({this.assetProvider, this.context})
  {
    _init();
  }

  void _init() async
  {
    //Recupera portifólio
    _portfolioList = await portfolioProvider.getPortfolio();
    FNET fnetDummy = FNET();
    fnetDummy.dividend = 0.0;
    _fnetList = List.filled(_portfolioList.length, fnetDummy);
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

    FNET fnet = FNET();
    fnet.dividend = 0.0;
    _fnetList.add(fnet);

    notifyListeners();

    //Adiciona o ativo ao portifólio
    portfolioProvider.addToPortfolio(portfolioAsset);

    //Redundandte passar "_enteredAsset"
    updateFnet([_enteredAsset]);

    return isValid;
  }

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

  void removeAsset(int removeIndex)
  {
    //Atualiza o valor total dos dividendos
    _totalEarnings -= _portfolioList[removeIndex].amount * _fnetList[removeIndex].dividend;

    portfolioProvider.removeAssetFromPorfolio(_portfolioList[removeIndex].ticker);

    //Atualiza a lista de portifolio
    _portfolioList.remove(_portfolioList[removeIndex]);

    //Atualiza a lista de fnet
    _fnetList.remove(_fnetList[removeIndex]);

    notifyListeners();
  }

  void editAsset(int editIndex)
  {
    print('Edit asset: ');
    print(_enteredAmount);

    //Novo - Antigo
    _totalEarnings += ( (int.parse(_enteredAmount) - _portfolioList[editIndex].amount)  * _fnetList[editIndex].dividend ) ;

    //Atualiza qtd
    _portfolioList[editIndex].amount = int.parse(_enteredAmount);

    notifyListeners();

    portfolioProvider.editAssetFromPorfolio(_portfolioList[editIndex]);
  }

   String get enteredAsset => _enteredAsset;
   void set enteredAsset(String asset)=> _enteredAsset = asset;

   String get enteredAmount => _enteredAmount;
   void set enteredAmount(String amount)=> _enteredAmount = amount;

   List<PortfolioAsset> get portfolioList => _portfolioList;

   List<FNET> get fnetList => _fnetList;

   double get totalEarnings => _totalEarnings;
}