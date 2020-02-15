import 'package:flutter/material.dart';
import 'package:minerva_investimentos/providers/asset_provider.dart';
import 'package:minerva_investimentos/widgets/homeCard.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Color mainColor = Colors.transparent;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          )
        ),


      child: Consumer<AssetProvider>(
         builder: (context, assetProvider, _) {
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

         },
      ),
    );
  }
}
