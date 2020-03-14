

import 'package:http/http.dart';
import 'package:minerva_investimentos/data/db_data.dart';
import 'package:minerva_investimentos/data/marked_data.dart';
import 'package:minerva_investimentos/models/fnet_model.dart';
import 'package:minerva_investimentos/models/investing_model.dart';
import 'package:minerva_investimentos/utils/functions.dart';

class InvestingProvider
{
   MarketData _marketData = MarketData();
   Functions _functions = Functions();

    //Recupera do investing.com os valores de uma lista de ativo para a data base do respectivo ativo
    Future<List<InvestingDayValue>> getInvestingDayValue(List<String> tickerList, List<FNET> dataList) async
    {
      List<InvestingDayValue> investingDayValueList = List<InvestingDayValue>();

      //Recupera os valores para cada ativo na lista
      int i = 0;
      for (String ticker in tickerList)
      {
        String date = dataList[i].baseDate;
        String year = date.substring(6, 10);
        String month = date.substring(3, 5);
        String day = date.substring(0, 2);      

        String pairId = await _marketData.getInvesingTickerId(ticker); 

        String response = await _marketData.getInvestingDayValue(ticker, day, month, year, pairId);

        //Aplica regex na pagina do site para recuperar as informações
        InvestingDayValue investingDayValue = _functions.regexInvestingDate(response);

        investingDayValueList.add(investingDayValue);

        i++;
     }

     return investingDayValueList;
   }

  //Recupera do investing.com os valores de uma lista de ativo para a data atual
   Future<List<InvestingCurrentValue>> getInvestingCurrentValue(List<String> tickerList) async
   {
      List<InvestingCurrentValue> investingCurrentValueList = List<InvestingCurrentValue>();

      String year = DateTime.now().year.toString();
      String month = DateTime.now().month.toString();
      String day = DateTime.now().day.toString();   

      //Recupera os valores para cada ativo na lista
      for (String ticker in tickerList)
      {
        BdData db = BdData();

        var query = await db.queryInvestingTable(ticker);

        //Verifica se a query estva vazia
        //Caso nao esteja, recebe o valor do pairId
        String pairId = query.isEmpty ? "" : query[0]["pairId"];

        //Recup0era o pairId do ativo
        //Procura no BD
        //Caso não exista, acessa o site e insere no bd
        if(pairId.isEmpty || pairId == null)
        {
          pairId  = await _marketData.getInvesingTickerId(ticker);

          List<int> insertIndex = await  db.insertInvesting(ticker, pairId);
        }       

        String response = await _marketData.getInvestingCurrentValue(ticker, day, month, year, pairId);

        //Aplica regex na pagina do site para recuperar as informações
        InvestingCurrentValue investingCurrentValue = _functions.regexInvestingValue(response);

        investingCurrentValueList.add(investingCurrentValue);
      }

      print('object');
      return investingCurrentValueList;
   }


}