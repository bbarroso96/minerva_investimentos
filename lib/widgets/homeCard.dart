import 'package:flutter/material.dart';
import 'package:minerva_investimentos/models/asset_model.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({Key key, this.portfolioAsset})
      : super(key: key);

final PortfolioAsset portfolioAsset;

  @override
  Widget build(BuildContext context) {
    double mockDiv = 124.48;
    double totalDividend = mockDiv*portfolioAsset.amount;

    Text price = Text('123,45');
    Text dividendo = Text('0,82'); 

   RichText dividend = RichText(
      
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>
        [
          TextSpan(text: "DY: " + mockDiv.toString(),
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16  )
          ),
          TextSpan(text: "\nTotal: " + (totalDividend.toString()),
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 12 )
          ),
        ]
      ),
    );
    
    RichText ticker = RichText(
      
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>
        [
          TextSpan(text: portfolioAsset.assetTicker,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16  )
          ),
          TextSpan(text: "\nx " + portfolioAsset.assetAmount.toString(),
            style: TextStyle(fontWeight:  FontWeight.w300, fontSize: 12 )
          ),
        ]
      ),
    );

    Text ativo = Text(portfolioAsset.assetTicker);
    Text qtd = Text(portfolioAsset.assetAmount.toString());

    return Card(
      margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ticker, SizedBox(width: 10,)
                    ,price
                  ],
                ),
                dividend
               ] ,
            ),
            Divider(),
            Text('separator')
          ],
        ),
      ),
    );
  }
}
