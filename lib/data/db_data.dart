


import 'package:minerva_investimentos/models/asset_model.dart';
import 'package:minerva_investimentos/models/fnet_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BdData
{

//Cria o banco de dados
Future<Database> createDatabase() async {
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'minerva_investimentos_1.db');

  Database database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
  return database;
}

void populateDb(Database database, int version) async {
  await database.execute("CREATE TABLE asset ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT,"
          "ticker TEXT,"
          "fund TEXT"
          ")");

  await database.execute("CREATE TABLE portfolio ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "ticker TEXT,"
          "amount INT"
          ")");

  
  await database.execute("CREATE TABLE fnet ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "infoDate TEXT,"
          "baseDate TEXT,"
          "paymentDate TEXT,"
          "dividend REAL,"
          "referenceDate TEXT,"
          "year TEXT,"
          "ticker TEXT"
          ")");

   await database.execute("CREATE TABLE investing ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "ticker TEXT,"
          "pairId TEXT"
          ")");
}

Future<List<int>> createCustomer(List<B3Asset> asset) async {
  Database db = await createDatabase();

  List<int> result = List<int>();

  for (B3Asset isertObject in asset)
  {
     result.add( await db.insert("asset", isertObject.toMap()) );
  }
 

  db.close();
  return result;
}

Future<List<int>> insertAssetList(List<B3Asset> asset) async {
  Database db = await createDatabase();

  List<int> result = List<int>();

  for (B3Asset isertObject in asset)
  {
     result.add( await db.insert("asset", isertObject.toMap()) );
  }
 

  db.close();
  return result;
}

Future<List> queryAssetTable() async {

  Database db = await createDatabase();

  var result = await db.query("asset", columns: ["id", "name", "ticker", "fund"]);

  //db.close();

  return result.toList();
}


Future<List> getCustomers() async {

  Database db = await createDatabase();

  var result = await db.query("asset", columns: ["id", "name", "ticker", "fund"]);

  db.close();

  return result.toList();
}


//////////////////////////////////////////////////////////////////
//     Portfolio
//////////////////////////////////////////////////////////////////
Future<List<int>> insertPortfolioAsset(PortfolioAsset asset) async {
  Database db = await createDatabase(); 

  List<int> result = List<int>();

  result.add( await db.insert("portfolio", asset.toMap()) );
 
  await db.close();
  return result;
}

Future<List<Map<String, dynamic>>> queryPortfolioTable() async 
{
  try
  {
    Database db = await createDatabase();

  var result = await db.query("portfolio", columns: ["id", "ticker", "amount"]);
  
  await db.close();

  return result.toList();
  }
  catch(e)
    {
      print(e.toString());
      throw Exception(e);
    }
}

  Future<int> removeFromPortfolioTable(String ticker) async
  {
     try
    {
      Database db = await createDatabase();

      int i = await db.delete("portfolio", where:'ticker = ?', whereArgs: [ticker]);

      await db.close();

      return i;
    }
    catch(e)
    {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<int> editFromPortfolioTable(PortfolioAsset asset) async
  {
     try
    {
      Database db = await createDatabase();

      int i = await db.update("portfolio",  asset.toMap(), where:'ticker = ?', whereArgs: [asset.ticker]);

      await db.close();

      return i;
    }
    catch(e)
    {
      print(e.toString());
      throw Exception(e);
    }
  }

//////////////////////////////////////////////////////////////////
///     FNET
//////////////////////////////////////////////////////////////////
Future<List<int>> insertFnet(FNET fnet) async {
  Database db = await createDatabase();

  List<int> result = List<int>();

  result.add( await db.insert("fnet", fnet.toMap()) );
 
  await db.close();
  return result;
}

Future<List<Map<String, dynamic>>> queryAllFnetTable() async 
{
  try
  {
    Database db = await createDatabase();

    var result = await db.query("fnet", columns: ["id","infoDate","baseDate","paymentDate","dividend","referenceDate","year","ticker"]);
  
    //await db.close();

  return result.toList();
  }
  catch(e)
    {
      print(e.toString());
      throw Exception(e);
    }
  }

Future<List<Map<String, dynamic>>> queryFnetTable(String asset) async 
{
  try
  {
    Database db = await createDatabase();

    var result = await db.query("fnet", columns: ["id","infoDate","baseDate","paymentDate","dividend","referenceDate","year","ticker"],
                                        where: "ticker = ?", whereArgs: [asset]);
  
    //await db.close();

  return result.toList();
  }
  catch(e)
    {
      print(e.toString());
      throw Exception(e);
    }
  }

  

//////////////////////////////////////////////////////////////////
/// investing.com
//////////////////////////////////////////////////////////////////
Future<List<Map<String, dynamic>>> queryInvestingTable(String asset) async 
{
  try
  {
    Database db = await createDatabase();

    var result = await db.query("investing", columns: ["id","ticker","pairId"],
                                        where: "ticker = ?", whereArgs: [asset]);
  
    //await db.close();

  return result.toList();
  }
  catch(e)
    {
      print(e.toString());
      throw Exception(e);
    }
  }

Future<List<int>> insertInvesting(String ticker, String pairId) async {
  Database db = await createDatabase();

  List<int> result = List<int>();

  Map<String, dynamic> investingMap = Map();
  investingMap["ticker"] = ticker;
  investingMap["pairId"] = pairId;

  result.add( await db.insert("investing", investingMap) );
 
  await db.close();
  return result;
}












}