import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' ;

class DatabaseHelper {

  static final _databaseName = "projetflutterkhahou";
  static final _databaseVersion = 1;


  static final table_admin = 'admin';
  static final column_id = 'id_admin';
  static final column_name = 'nom_admin';
  static final column_email = 'email';
  static final column_password = 'password';

  static final table_famille = 'famille';
  static final columnn_ref = 'reff_family';
  static final columnn_name = 'name_famille';


  static final table_composant = 'composant';
  static final columnnn_id = 'id_composant';
  static final columnn_description = 'description_composant';
  static final columnnn_name = 'name_composant';
  static final columnn_quantite = 'qte';
  static final columnn_famcomp = 'famille_composant';
  static final date_accui = 'aa';
  static final date_retour = 're';

  static final table_membre = 'membre';
  static final columnnm_id = 'id_membre';
  static final columnnm_name = 'name_membre';
  static final columnnm_description = 'description_membre';
  static final column_numtel1 = 'numtel1';
  static final column_numtel2 = 'numtel2';


  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //static Database? _database ;
  //Future<Database> get database async {
  //if (_database != null) return _database!;
  //_database = await _initDatabase();
  //return _database!;
  //}
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onConfigure: _onConfigure
    );
  }


  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $table_admin ("
            "$column_id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "   $column_name TEXT NOT NULL,"
            "$column_email TEXT NOT NULL,"
            " $column_password TEXT NOT NULL"
            ")"


    );

    await db.execute(
        "CREATE TABLE $table_famille ("
            "   $columnn_ref TEXT PRIMARY KEY,"
            "$columnn_name TEXT NOT NULL "
            ")"
    );


    await db.execute('''
          CREATE TABLE $table_composant (
            $columnnn_id TEXT PRIMARY KEY,
            $columnnn_name TEXT NOT NULL,
            $columnn_quantite INTEGER NOT NULL,
            $date_accui TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            $date_retour TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
            $columnn_famcomp TEXT NOT NULL,
            FOREIGN KEY ($columnn_famcomp) REFERENCES $table_famille ($columnn_ref) ON DELETE NO ACTION ON UPDATE NO ACTION
          )
          ''');

    await db.execute(
        "CREATE TABLE $table_membre ("
            "$columnnm_id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "   $columnnm_name TEXT ,"
            "$columnnm_description TEXT ,"
            "$column_numtel1 INTEGER  ,"
            "$column_numtel2 INTEGER "
            ")"


    );
  }


  Future<List<Map<String, dynamic>>> getAllCom() async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "SELECT $columnnn_id  , $columnnn_name ,$columnn_quantite , $columnn_name "
            "FROM $table_composant INNER JOIN $table_famille ON $columnn_famcomp = $columnn_name");

    return res;
  }

  Future<List<Map<String, dynamic>>?> getLoginUser(String userEm,
      String password) async {
    var dbClient = await database;
    var res = await dbClient.rawQuery("SELECT * FROM $table_admin WHERE "
        "$column_email = '$userEm' AND "
        "$column_password = '$password'");

    if (res.length > 0) {
      return res;
    }

    return null;
  }

  Future<List<Map<String, dynamic>>?> getComposantFamily(String fam) async {
    var dbClient = await database;
    var res = await dbClient.rawQuery("SELECT * FROM $table_famille WHERE "
        "$columnn_name = '$fam' ");

    if (res.length > 0) {
      return res;
    }

    return null;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table_admin, row
    );
  }

  Future<int> insertFamily(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table_famille, row);
  }

  Future<int> insertComposant(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table_composant, row
    );
  }

  Future<int> insertMembre(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table_membre, row
    );
  }


  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table_admin);
  }


  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table_admin'));
  }

  Future<List<Map<String, dynamic>>> getAllComposant() async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "SELECT $columnnn_id , $columnnn_name  ,$columnn_quantite ,$date_accui, $date_retour , $columnn_name "
            "FROM $table_composant INNER JOIN $table_famille ON $columnn_famcomp = $columnn_ref");

    return res;
  }


  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[column_id];
    return await db.update(
        table_admin, row, where: '$column_id = ?', whereArgs: [id]);
  }


  Future<List<Map<String, dynamic>>> getAllfam() async {
    Database db = await instance.database;
    var res = await db.rawQuery("SELECT  $columnn_name FROM $table_famille");

    return res;
  }


  Future<List<Map<String, dynamic>>?> getIdfam(String fam) async {
    Database db = await instance.database;
    var res = await db.rawQuery("SELECT $columnn_ref FROM $table_famille WHERE "
        "$columnn_name='$fam'");
    if (res.length > 0) {
      return res;
    }
    else
      return null;
  }

  Future<int> updateComposant(Map<String, dynamic> row) async {
    Database db = await instance.database;
    String id = row[columnnn_id];
    return await db.update(
        table_composant, row, where: '$columnnn_id = ?', whereArgs: [id]);
  }


  Future<int> deleteComponent(String id) async {
    Database db = await instance.database;
    return await db.delete(
        table_composant, where: '$columnnn_id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>?> recher(String word) async {
    Database db = await instance.database;
    var res = await db.query(table_composant, where: 'name_composant LIKE ?',
        whereArgs: ['%$word%']);
    if (res.length > 0) {
      return res;
    }
    else
      return null;
  }
}







