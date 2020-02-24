import 'package:flutter/material.dart';
import 'package:minerva_investimentos/models/asset_model.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({Key key, this.portfolioAsset})
      : super(key: key);

final PortfolioAsset portfolioAsset;

  @override
  Widget build(BuildContext context) {
 Text ativo = Text(portfolioAsset.assetTicker);
   Text cotacao = Text(portfolioAsset.assetAmount.toString());
   Text dividendo = Text('123');

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
                    ativo, SizedBox(width: 10,)
                    ,dividendo
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("DY: "),
                    cotacao
                  ],
                )],
            ),
            Divider(),
            Text('separator')
          ],
        ),
      ),
    );
  }
}
