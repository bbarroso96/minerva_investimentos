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
                      //DEBUG testando delete
                      //provider.removeAsset('ticker');
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
                    //child: Text("Proventos Jan 2020",
                    child: Text("Proventos  "+ DateTime.now().month.toString()+"/"+DateTime.now().year.toString(),
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    preferredSize: null)),

            body: ListView.builder(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              itemCount: provider.homeCardListLength,
              itemBuilder: (context, int index) {
                return Dismissible(
                  child: provider.homeCardWidgetList[index],

                  //Swipe para a direita (CONFIG)
                  background: Card(
                    color: Colors.blueGrey,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        child: Icon(Icons.settings),
                        padding: const EdgeInsets.only(left: 10),)),
                  ),

                  //Swipe para a esquerda (DELETE)
                  secondaryBackground: Card(
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        child: Icon(Icons.delete),
                        padding: const EdgeInsets.only(right: 10),)),
                  ),

                  //A key do card é o próprio nome do ativo
                  key: ValueKey(provider.homeCardWidgetList[index].portfolioAsset.ticker),

                  confirmDismiss: (direction) async {
                    //Swipe deletando
                    if (direction == DismissDirection.endToStart) {
                      final bool confirm = await _showConfirmDialog(context);

                      return confirm;
                    }
                    //Swipe config
                    else {
                      _settingModalBottomSheetEdit(
                        context, 
                        provider,
                        index
                       );
                      return false;
                    }
                  },

                  onDismissed: (direction) async {
                    //Remove do portifólio o ativo quando o swipe for pra esqueda
                    if (direction == DismissDirection.endToStart) {
                      print('Deletando do portifolio: ' +
                          provider.homeCardWidgetList[index].portfolioAsset.ticker);
                      provider.removeAsset(provider.homeCardWidgetList[index]);
                    }
                  },
                );
              },
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

  Future<bool> _showConfirmDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you wish to delete this item?"),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("DELETE")),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
    );
  }

  void _settingModalBottomSheet(context, HomeProvider provider) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        //Imput ativo
                        Flexible(
                          flex: 4,
                            child: TextFormField(     
                              decoration: InputDecoration(helperText: 'Ativo'),                      
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.characters,
                              obscureText: false,
                              autovalidate: true, //Define autovalidação                              
                          ),
                        ),

                     SizedBox(width: 10,),

                        //Imput qtd
                        Flexible(
                          flex: 1,
                            child: TextFormField(
                              decoration: InputDecoration(helperText: 'Qtd'),
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              autovalidate: true, //Define autovalidação
                              validator: (String amout) {
                              provider.enteredAmount = amout;
                            },
                            
                          ),
                        ),
                        
                        Flexible (
                          flex: 1,
                          child: IconButton(
                            icon: Icon(Icons.check),
                            onPressed: (){provider.submitAsset(); Navigator.pop(context);}
                          )
                        )

                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      }
       void _settingModalBottomSheetEdit(context, HomeProvider provider, int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        //Imput ativo
                        Flexible(
                          flex: 4,
                            child: TextFormField( 
                              enabled: false,
                              initialValue: provider.homeCardWidgetList[index].portfolioAsset.ticker,    
                              decoration: InputDecoration(helperText: 'Ativo'),                      
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.characters,
                              obscureText: false,
                              autovalidate: true, //Define autovalidação
                              validator: (String asset) {
                              provider.enteredAsset = asset.toUpperCase();
                            },
                          ),
                        ),

                     SizedBox(width: 10,),

                        //Imput qtd
                        Flexible(
                          flex: 1,
                            child: TextFormField(
                              initialValue: provider.homeCardWidgetList[index].portfolioAsset.amount.toString(),
                              decoration: InputDecoration(helperText: 'Qtd'),
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              autovalidate: true, //Define autovalidação
                              validator: (String amout) {
                              provider.enteredAmount = amout;
                            },
                            
                          ),
                        ),
                        
                        Flexible (
                          flex: 1,
                          child: IconButton(
                            icon: Icon(Icons.check),
                            onPressed: (){provider.editAsset(index); Navigator.pop(context);}
                          )
                        )

                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });}

}
