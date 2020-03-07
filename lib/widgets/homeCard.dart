import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:minerva_investimentos/models/asset_model.dart';
import 'package:minerva_investimentos/models/fnet_model.dart';

class HomeCardWidget extends StatelessWidget {

  const HomeCardWidget({Key key, this.portfolioAsset, this.fnetData})
      : super(key: key);

  final PortfolioAsset portfolioAsset;
  final FNET fnetData;

  @override
  Widget build(BuildContext context) {

    double totalDividend = fnetData.dividend * portfolioAsset.amount;
    Text price = Text('123,45');
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
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16  )
          ),
          TextSpan(text: "\nTotal: " + (totalDividend.toStringAsFixed(2)),
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 12 )
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16  )
          ),
          TextSpan(text: " x" + portfolioAsset.assetAmount.toString(),
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 12 )
          ),
          TextSpan(text: "\nProvento: " + "0,52%",
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 12 )
          ),
        ]
      ),
    );

    //////////////////////////////////////////////////////////////////////
    ///Monta texto do preco medio
    //////////////////////////////////////////////////////////////////////
    double mockPrice = 120.00;
    int mockGain = 10;
    RichText averagePrice = RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>
        [
          TextSpan(text: "PM: " + mockPrice.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16  )
          ),
          TextSpan(text: "\n+\$"+(mockPrice*mockGain/100).toStringAsFixed(2),
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 12, color: Colors.green )
          ),
          TextSpan(text: " | ",
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 12, color: Colors.green )
          ),
          TextSpan(text: "+"+ mockGain.toString() + "%",
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 12, color: Colors.green )
          ),
        ]
      ),
    );

    //////////////////////////////////////////////////////////////////////
    ///Monta texto da cotação
    //////////////////////////////////////////////////////////////////////
    double mockstock = 122.00;
    int mockstockGain = 1;
    RichText stockValue = RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>
        [
          TextSpan(text: "\$" + mockstock.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16  )
          ),
          TextSpan(text: " | ",
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 12 )
          ),
          TextSpan(text: "+"+mockstockGain.toString()+"%",
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 12, color: Colors.green)
          ),
          TextSpan(text: "\nAbertura: "+ mockPrice.toString(),
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 12 )
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
                ,dividend
                //,averagePrice
                ,stockValue
               ],
            ),
            Divider(),
            Text('separator')
          ],
        ),
      ),
    );
  }
}
