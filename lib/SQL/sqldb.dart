import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class sqlDB {

  static final sqlDB _instant = sqlDB._();
  sqlDB._();

  factory sqlDB() {
    return _instant;
  }

  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    // path DB is Ging
    String datatbasepath = await getDatabasesPath();
    // join( 'brd' , 'to' , 'for' ) =>> brd/to/for
    // path great new My_DB
    String path =
        join(datatbasepath, 'notes.sql'); //=> datatbasepath/not_onGreate
    // open the new_DB
    Database mydb = await openDatabase(path,
        version:8, onCreate: _onGreate, onUpgrade: _onUpgrade);
    return mydb;
  }

  // Great Tabel in SQL
  FutureOr<void> _onGreate(Database db, int version) async {
    await db.execute('CREATE TABLE users('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'email VARCHAR(100) NOT NULL ,'
        'name VARCHAR(100) NOT NULL ,'
        'password VARCHAR(100) NOT NULL '
        ')');
    await db.execute('CREATE TABLE notes ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'title VARCHAR(250),'
        'info TEXT,'
        'user_id INTEGER NOT NULL,'
        'FOREIGN KEY (user_id) REFERENCES users(id) oN DELETE NO ACTION'
        ')');
    print('CREATE TABLE DataBase AND Table ============== ');
  }

//******************************************************************
  // CRUD >> insert , read , update , delete  >>>> in SQL
  //readData(String sql) async {
  //  Database? mydb = await db;
  //  List<Map> response = await mydb!.rawQuery(sql);
  //  return response;
  //}
//
  ////insertData(String table, Map<String, dynamic> rowData) async {
  //insertData(String sql ) async{
  //  Database? mydb = await db;
  //  int response = await mydb!.rawInsert(sql) ;
  //  //int response = await mydb!.insert(table, rowData);
  //  return response;
  //}
  //updateData(String sql) async {
  //  Database? mydb = await db;
  //  int response = await mydb!.rawUpdate(sql);
  //  return response;
  //}
//
  //deleteData(String sql) async {
  //  Database? mydb = await db;
  //  int response = await mydb!.rawDelete(sql);
  //  return response;
  //}

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('ALTER TABLE notes ADD COLUMN import BIT DEFAULT 0 ');
    print('onUpgrade DataBase AND Tabel ============== ');
  }
}
