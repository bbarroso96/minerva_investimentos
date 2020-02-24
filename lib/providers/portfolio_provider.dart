

import 'package:minerva_investimentos/data/db_data.dart';
import 'package:minerva_investimentos/models/asset_model.dart';

class PortfolioProvider
{
  List<PortfolioAsset> _portfolioList;
  BdData bd = BdData();

    PortfolioProvider()
    {
      //_init();

    }


    Future<void> _init() async
    {
      //Tenta recuperar a lista de ativos listados na b3 armazenados no bd
      var bdPortfolio = await bd.queryPortfolioTable();

      //Caso exista dados no bd segue para o processamento

        int i = 0;
        print('ATIVOS JÀ NO SQL');
        for (var item in bdPortfolio) {
          print(bdPortfolio[i]);
          i++;
        }
    }

  
  Future<void> addToPortfolio(PortfolioAsset portfolioAsset) async
  {
    bd.insertPortfolioAsset(portfolioAsset);

  }

  ///Retorna a lista de ativos do portifólio
  ///Ticker e quantidade
  Future<List<PortfolioAsset>> getPortfolio() async
  {
      List<PortfolioAsset> portfolioList = List<PortfolioAsset>();

      //Busca dados do bd
      var queryReult = await bd.queryPortfolioTable();

      for (var item in queryReult) {
        portfolioList.add(PortfolioAsset.fromJson(item)) ;
      }

        //DEBUG: printa a resposta
        for (PortfolioAsset a in portfolioList)
        {
          print(a.amount);
          print(a.ticker);
        }
    
    return portfolioList;
  }
  
  //Remove ativo do portifólio
  Future<int> removeAssetFromPorfolio(String ticker) async
  {
    int i = await bd.removeFromPortfolioTable(ticker);

    return i;
  }

   //Remove ativo do portifólio
  Future<int> editAssetFromPorfolio(PortfolioAsset asset) async
  {
    int i = await bd.editFromPortfolioTable(asset);

    return i;
  }
     
}