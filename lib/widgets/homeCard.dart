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
    double dividendYeld = fnetData.dividend *100 / double.parse(investingDayValue.price);
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
          TextSpan(text: "\nProvento: " + dividendYeld.toStringAsFixed(2) +"%",
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14 )
          ),
        ]
      ),
    );

    //////////////////////////////////////////////////////////////////////
    ///Monta texto do preco medio
    //////////////////////////////////////////////////////////////////////
    //double avPrice = 140.00;
    double avPrice = portfolioAsset.averagePrice;
    double gain = double.parse(investingCurrentValue.price) - avPrice;
    double gainVar = ( gain /avPrice)*100;
    RichText averagePrice = RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,  
        children: <TextSpan>
        [
          TextSpan(text: "PM: " + avPrice.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18  )
          ),
          TextSpan(text: "\n\$"+gain.toStringAsFixed(2),
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14, color: (gain) > 0 ? Colors.green : Colors.red)
          ),
          TextSpan(text: " | ",
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14, color: (gain) > 0 ? Colors.green : Colors.red)
          ),
          TextSpan(text:  gainVar.toStringAsFixed(2) + "%",
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14, color: (gain) > 0 ? Colors.green : Colors.red)
          ),
        ]
      ),
    );

    //////////////////////////////////////////////////////////////////////
    ///Monta texto da cotação
    //////////////////////////////////////////////////////////////////////
    double priceVar = ( double.parse(investingCurrentValue.price) - double.parse(investingCurrentValue.open) )/double.parse(investingCurrentValue.open)*100;
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
          TextSpan(text: priceVar.toStringAsFixed(2)
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

   /* return Card(
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
    );*/

    return Card(
      margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      color: Colors.white,
      child: ExpansionTile(
        //subtitle: Center(child: Text('...')),
        trailing: Text(''),

        title:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ticker
              //,averagePrice
              ,stockValue
              ,dividend
             ],
          ),


        children: <Widget>[
          Padding(child: Divider(height: 8, thickness: 1), padding:const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0)),
          //Align(alignment: Alignment.centerLeft, child: Text("Data Pagamento: "+fnetData.paymentDate.toString())),
          //Align(alignment: Alignment.centerLeft, child:Text("Preco Pagamento: "+investingDayValue.price.toString()) ),
          //Align(alignment: Alignment.centerLeft, child:Text("Maxima: " + investingCurrentValue.high)),
          //Align(alignment: Alignment.centerLeft, child:Text("Minima: " + investingCurrentValue.low)),
          //Align(alignment: Alignment.centerLeft, child:Text("Preço Médio: " + avPrice.toStringAsFixed(2))),
          //Align(alignment: Alignment.centerLeft, child:Text("Ganho/Perda: " + "\$"+ gain.toStringAsFixed(2) + " | " + gainVar.toStringAsFixed(2) + "%")),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              averagePrice,
              RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>
        [
          TextSpan(text: "Max: ",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16  )
          ),
          TextSpan(text: investingCurrentValue.high,
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14, color: Colors.green)
          ),
          TextSpan(text: "\nMin: ",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16  )
          ),
          TextSpan(text: investingCurrentValue.low,
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14, color: Colors.red)
          ),
        ]
      ),
    ),
            ],
          ),
    RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>
        [
          TextSpan(text: "Data Pgt: ",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16  )
          ),
          TextSpan(text: fnetData.paymentDate.toString(),
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14 )
          ),
          TextSpan(text: "\nValor Data Base: ",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16  )
          ),
          TextSpan(text: investingDayValue.price.toString(),
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14 )
          ),
        ]
      ),
    ),

/*
    RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>
        [
          TextSpan(text: "Preço Med: ",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16  )
          ),
          TextSpan(text: avPrice.toStringAsFixed(2),
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14 )
          ),
          TextSpan(text: "\nGanho/Perda: ",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16  )
          ),
          TextSpan(text: "\$"+ gain.toStringAsFixed(2) + " | " + gainVar.toStringAsFixed(2) + "%",
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 14, color: ((double.parse(investingCurrentValue.price) - double.parse(investingCurrentValue.open)) > 0 ? Colors.green : Colors.red))
    ),
        ]
      ),
    )
*/
         
        ], 
      ),
    );

    
  }
}

 // final PortfolioAsset portfolioAsset;
  //final FNET fnetData;
  //final InvestingDayValue investingDayValue;
  //final InvestingCurrentValue investingCurrentValue;