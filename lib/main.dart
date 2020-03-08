import 'package:flutter/material.dart';
import 'package:minerva_investimentos/providers/asset_provider.dart';
import 'package:minerva_investimentos/utils/router.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());


/* 
TODO:

  -- Implementar PIN:
  -- null

  --OK:
      -- Salvar PIN caso não exisa um na memória (primiero login)
      -- Recuperar PIN e autenticar usuário
      -- Esconder/Mostrar campo de senha
      -- Alteração de PIN
      -- Acesso com digital no lugar do PIN
      -- shared_preferences para salvar PIN
      
      

  
  -- Implementar SQLite
  -- null

  --OK:
      -- Tabela para salvar a lista de ativos
      -- Tabela para salvar cada importação da FNET sobre os dividendos


  --OK (problema):
    -- Apenas 5 get por min, não atende
    -- Implementar acesso a API da Alpha Vantage
    -- Recupera dados intraday

  --OK:
    burla o alpha pegando os dados do Investing.com
    -- Acessa o dia base do dividendo para calcular rentabilidade
    -- Acessa o último dia útil para pegar o valor atual do mercado

  OBS: onde salvar valor de abertura/fechamento do mercado?
    -- Muito provavelmente com o prório ativo (Classe de "ASSET")



  OQ FALTA:
    -- atualizar periodicamente o valor de mercado
    -- ou usar o pull to refresh ???

    -- armazenar os dados do ultimo dividendo para pegar junto

    -- !!! logica para verificar se é para procurar o documento mais rescente de dividendos

*/






class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: 
      [
        Provider<AssetProvider>(create: (_) => AssetProvider(),)
      ],
        child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
         
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: Router.generateRoute,
        initialRoute: loginRoute,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
