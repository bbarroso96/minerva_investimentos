


import 'package:flutter/cupertino.dart';
import 'package:minerva_investimentos/data/B3_data.dart';
import 'package:minerva_investimentos/data/db_data.dart';
import 'package:minerva_investimentos/models/asset_model.dart';
import 'package:minerva_investimentos/utils/functions.dart';

class AssetProvider extends ChangeNotifier
{
    List<B3Asset> _assetList;


    AssetProvider()
    {
      _init();
    }


    Future<void> _init() async
    {
      //Tenta recuperar a lista de ativos listados na b3 armazenados no bd
      BdData bd = BdData();
      B3Data b3Data = B3Data();
      Functions functions = Functions();
      var bdAssetList = await bd.queryAssetTable();

      //Caso exista dados no bd segue para o processamento
      if(bdAssetList != null)
      {
        var a = await bd.queryAssetTable();

        int i = 0;
        print('ATIVOS JÀ NO SQL');
        for (var item in a) {
          print(a[i]);
          i++;
        }
      }
      //Caso não existam dados no bd, tenta recuperar no site da B3 e armazenar no bd
      else
      {
        //Recupera site da b3 com a lista de fii
        String b3Response = await b3Data.getFiiListFromB3();

        //Aplica regex no HTML e recupera lista de Assets
        List<B3Asset> assetListFromRegex = functions.regexAssetList(b3Response); 

        //Preenche retorna aos consumidores a lista de ativos
        //TODO: lógica para inserir apenas os ativos novos e depois retornar alista completa
        _assetList = assetListFromRegex;
        notifyListeners();

        //Salva no bd a lista de ativos
        var b = await bd.insertAssetList(assetListFromRegex);

        //DEBUG: le a lista de ativos que foi inserida
        Future.delayed(Duration(milliseconds: 3000));
        var a = await bd.queryAssetTable();

        int i = 0;
        print('TABLEA APOS INSERSAO');
        for (var item in a) {
          print(a[i]);
          i++;
        }

        //TODO: salvar na meoria 
      }

    }





















  Future<void> a()
  async {
        //TODO: implementação da lógica de armazear os ativos
          
          BdData bd = BdData();

          B3Asset asset = B3Asset();

          asset.name = "Fundo novo";
          asset.ticker = "EFGH";
          asset.fund = "Fundo novo";

        List<B3Asset> listAsset = List<B3Asset>();
        listAsset.add(asset);
        listAsset.add(asset);

        //var b = await bd.createCustomer(listAsset);
        Future.delayed(Duration(milliseconds: 3000));
        var a = await bd.getCustomers();

        int i = 0;
        for (var item in a) {
          print(a[i]);
          i++;
        }


  }


}