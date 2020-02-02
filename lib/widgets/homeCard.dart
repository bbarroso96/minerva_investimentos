import 'package:flutter/material.dart';


class HomeCardWidget extends StatelessWidget {

  const HomeCardWidget({Key key, this.ativo, this.cotacao, this.dividendo}) : super(key: key);

  final Text ativo;
  final Text cotacao;
  final Text dividendo;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),

      child: Card(
        color: Colors.white,

        child: Column(
          children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                ativo, dividendo, cotacao      
                ],
              ),
      Text( 'separator')
            
          ],
        ),
      ),
    );

  }
}
