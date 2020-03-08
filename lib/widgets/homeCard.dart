import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:minerva_investimentos/models/asset_model.dart';
import 'package:minerva_investimentos/models/fnet_model.dart';
import 'package:minerva_investimentos/models/investing_model.dart';

class HomeCardWidget extends StatelessWidget {

  const HomeCardWidget({Key key, this.portfolioAsset, this.fnetData, this.investingDayValue, this.investingCurrentValue})
      : super(key: key);

  final PortfolioAsset portfolioAsset;
  final FNET fnetData;
  final InvestingDayValue investingDayValue;
  final InvestingCurrentValue investingCurrentValue;

  @override
  Widget build(BuildContext context) {

    double totalDividend = fnetData.dividend * portfolioAsset.amount;
    Text price = Text('143,45');
    Text dividendo = Text('0,82'); 


    //////////////////////////////////////////////////////////////////////
    ///Monta texto do dividendo
    //////////////////////////////////////////////////////////////////////
   RichText dividend = RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>
        [
          TextSpan(text: "DY: " + fnetData.dividend.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18  )
          ),
          TextSpan(text: "\nTotal: " + (totalDividend.toStringAsFixed(2)),
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14 )
          ),
        ]
      ),
    );
    
    //////////////////////////////////////////////////////////////////////
    ///Monta texto do ticker
    //////////////////////////////////////////////////////////////////////
    RichText ticker = RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>
        [
          TextSpan(text: portfolioAsset.assetTicker,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18  )
          ),
          TextSpan(text: " x" + portfolioAsset.assetAmount.toString(),
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14 )
          ),
          TextSpan(text: "\nProvento: " + (double.parse(investingDayValue.price) * fnetData.dividend /100  ).toStringAsFixed(2) +"%",
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14 )
          ),
        ]
      ),
    );

    //////////////////////////////////////////////////////////////////////
    ///Monta texto do preco medio
    //////////////////////////////////////////////////////////////////////
    double mockPrice = 140.00;
    int mockGain = 10;
    RichText averagePrice = RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>
        [
          TextSpan(text: "PM: " + mockPrice.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18  )
          ),
          TextSpan(text: "\n+\$"+(mockPrice*mockGain/100).toStringAsFixed(2),
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14, color: Colors.green )
          ),
          TextSpan(text: " | ",
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14, color: Colors.green )
          ),
          TextSpan(text: "+"+ mockGain.toString() + "%",
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14, color: Colors.green )
          ),
        ]
      ),
    );

    //////////////////////////////////////////////////////////////////////
    ///Monta texto da cotação
    //////////////////////////////////////////////////////////////////////
    double mockstock = 142.00;
    int mockstockGain = 1;
    RichText stockValue = RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>
        [
          TextSpan(text: "\$" + investingCurrentValue.price,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18  )
          ),
          TextSpan(text: " | ",
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14 )
          ),
          //open - 100%
          //var - x%
          //x = var * 100 / open
          TextSpan(text: ( ( double.parse(investingCurrentValue.price) - double.parse(investingCurrentValue.open) )/double.parse(investingCurrentValue.open)*100  ).toStringAsFixed(2)
                        +"%",
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14, color: (double.parse(investingCurrentValue.price) - double.parse(investingCurrentValue.open)) > 0 ? Colors.green : Colors.red)
          ),
          TextSpan(text: "\nAbertura: "+ investingCurrentValue.open,
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14 )
          ),
        ]
      ),
    );










    //////////////////////////////////////////////////////////////////////
    ///CARD
    //////////////////////////////////////////////////////////////////////
    Text ativo = Text(portfolioAsset.assetTicker);
    Text qtd = Text(portfolioAsset.assetAmount.toString());

    return Card(
      margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ticker
                //,averagePrice
                ,stockValue
                ,dividend
               ],
            ),
            Divider(height: 8, thickness: 1),
            Text('...')
          ],
        ),
      ),
    );
  }
}
