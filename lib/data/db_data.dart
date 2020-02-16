


import 'package:minerva_investimentos/models/asset_model.dart';
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

  db.close();

  return result.toList();
}


Future<List> getCustomers() async {

  Database db = await createDatabase();

  var result = await db.query("asset", columns: ["id", "name", "ticker", "fund"]);

  db.close();

  return result.toList();
}

/*
     Portfolio
*/
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

}