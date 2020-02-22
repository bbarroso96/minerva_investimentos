import 'package:flutter/material.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({Key key, this.ativo, this.cotacao, this.dividendo})
      : super(key: key);

  final Text ativo;
  final Text cotacao;
  final Text dividendo;

  @override
  Widget build(BuildContext context) {
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
