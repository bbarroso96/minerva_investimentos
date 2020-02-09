


import 'package:minerva_investimentos/models/asset_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BdData
{

//Cria o banco de dados
Future<Database> createDatabase() async {
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'minerva_investimentos.db');

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

Future<List> getCustomers() async {

  Database db = await createDatabase();

  var result = await db.query("asset", columns: ["id", "name", "ticker", "fund"]);

  db.close();

  return result.toList();
}

}