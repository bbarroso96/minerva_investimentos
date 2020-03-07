

import 'package:http/http.dart';
import 'package:minerva_investimentos/data/marked_data.dart';
import 'package:minerva_investimentos/models/fnet_model.dart';
import 'package:minerva_investimentos/models/investing_model.dart';
import 'package:minerva_investimentos/utils/functions.dart';

class InvestingProvider
{
   MarketData _marketData = MarketData();
   Functions _functions = Functions();

   Future<List<InvestingDayValue>> getInVestingDayValue(List<String> tickerList, List<FNET> dataList) async
   {
     List<InvestingDayValue> investingDayValueList = List<InvestingDayValue>();

     int i = 0;
     for (String ticker in tickerList)
     {
        String date = dataList[i].baseDate;
        String year = date.substring(6, 10);
        String month = date.substring(3, 5);
        String day = date.substring(0, 2);       

        String response = await _marketData.getInVestingDayValue(ticker, day, month, year);

        InvestingDayValue investingDayValue = _functions.regexInvestingDate(response);

        investingDayValueList.add(investingDayValue);

        i++;
     }

     return investingDayValueList;
   }

}