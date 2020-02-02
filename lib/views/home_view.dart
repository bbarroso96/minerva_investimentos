import 'package:flutter/material.dart';
import 'package:minerva_investimentos/widgets/homeCard.dart';


class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Color mainColor = Colors.blue;

    return Scaffold(
      backgroundColor: mainColor,

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("R\$ 100,00 "),
      ),

      body: Column(
        children: <Widget>[
          HomeCardWidget(ativo: Text("TGAR11"), cotacao: Text("12,50"), dividendo: Text("0,50")   ),
          Text("card aqui"),
          Text("card aqui"),
          Text("card aqui")
        ],
      ),

    );
  }


}