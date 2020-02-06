import 'package:flutter/material.dart';
import 'package:minerva_investimentos/widgets/homeCard.dart';

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Color mainColor = Colors.indigo[800];

    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        
        backgroundColor: mainColor,
          elevation: 0,
          centerTitle: true,
          title: Text("R\$ 100,00 ",
              style: TextStyle(
                fontSize: 30,
              )),
          bottom: PreferredSize(
              child: Text("Proventos Jan 2020",
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              preferredSize: null)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50")),
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50")),
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50")),
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50")),
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50")),
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50")),
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50")),
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50")),
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50")),
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50")),
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50")),
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50")),
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50")),
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50")),
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50")),
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50")),
            HomeCardWidget(
                ativo: Text("TGAR11"),
                cotacao: Text("12,50"),
                dividendo: Text("0,50"))
          ],
        ),
      ),

      /*
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.assessment),title: Text("Ativos")),
        BottomNavigationBarItem(icon: Icon(Icons.business), title: Text("Carteira"))]
        ),*/
    );
  }
}
