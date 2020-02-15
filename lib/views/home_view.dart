import 'package:flutter/material.dart';
import 'package:minerva_investimentos/providers/asset_provider.dart';
import 'package:minerva_investimentos/providers/home_provider.dart';
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
      )),
      child: ChangeNotifierProvider<HomeProvider>(
        create: (_) => HomeProvider(
          assetProvider: Provider.of<AssetProvider>(context, listen: true),
        ),
        child: Consumer<HomeProvider>(builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: mainColor,
            appBar: AppBar(
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.plus_one),
                    onPressed: () {
                      _settingModalBottomSheet(context, provider);
                    },
                  )
                ],
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
            body: ListView.builder(
              itemCount: provider.homeCardListLength,
              itemBuilder: (context, int index) {
                return provider.homeCardWidgetList[index];
              }


                
              ,
            ),
            /*
              bottomNavigationBar: BottomNavigationBar(items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.assessment), title: Text("Ativos")),
                BottomNavigationBarItem(
                    icon: IconButton(
                      icon: Icon(Icons.business),
                      onPressed: () {
                        _settingModalBottomSheet(context);
                      },
                    ),
                    title: Text("Carteira"))
              ]),
              */
          );
        }),
      ),
    );
  }

  void _settingModalBottomSheet(context, HomeProvider provider) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child:  Column(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        autovalidate: true, //Define autovalidação
                        validator: (String asset)
                        {
                          provider.enteredAsset = asset;
                        },

                        onFieldSubmitted: (_) 
                        {
                          provider.submitAsset();
                        },
                      ),
                    ),
                  ),
                ],
              ),
          );
        });
  }
}
