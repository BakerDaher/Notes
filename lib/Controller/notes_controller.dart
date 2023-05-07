import 'package:restaurant/Controller/controller.dart';
import 'package:restaurant/model/notes.dart';
import 'package:sqflite/sqflite.dart';
import '../SQL/sqldb.dart';

class Note_controller extends DBcontroller<Notes>{

  Future<Database?> mydb = sqlDB().db ;
  Database? db ;

  @override
  Future<int> create(Notes model) async {
    // TODO: implement creat
    db = await mydb ;
    //insert(...) returns the row id of the new inserted record.
    int response = await db!.insert("notes", model.toMap()) ;
    return response ;
  }

  @override
  Future<bool> delete(int id) async {
    // TODO: implement delete
    db = await mydb ;
    // return 1 if delete , return 0 if not delete
    int response = await db!.delete("notes" ,where: 'id=?',whereArgs: [id]);
    return response == 1 ;
  }

  @override
  Future<List<Notes>> read() async {
    // TODO: implement read
    db = await mydb ;
    List<Map<String,dynamic>> response = await db!.query("notes") ;
    if( response.isNotEmpty){
      // بعد فرط الليست الى ماب من يوزر يحولهم اللى ليست
      return response.map((e) => Notes.fromMapData(e)).toList();
    }
    return [] ;
  }

  @override
  Future<bool> update(Notes model) async {
    // TODO: implement update
    db = await mydb ;
    int response = await db!.update("notes",  model.toMap() , where:'id=?' , whereArgs: [model.id] ) ;
    return response == 1 ;
  }

  @override
  Future<List<Notes>> show(int user_id) async{
    // TODO: implement show
    db = await mydb ;
    List<Map<String,dynamic>> response = await db!.query("notes" ,where: 'user_id=?',whereArgs: [user_id]) ;
    if( response.isNotEmpty){
      // بعد فرط الليست الى ماب من يوزر يحولهم اللى ليست
      return response.map((e) => Notes.fromMapData(e)).toList();
    }
    return [] ;
  }

  Future<Notes?> showNotes(int id) async{
    // TODO: implement show
    db = await mydb ;
    List<Map<String,dynamic>> response = await db!.query("notes" ,where: 'id=?',whereArgs: [id]) ;
    if( response.isNotEmpty){
      // بعد فرط الليست الى ماب من يوزر يحولهم اللى ليست
      return Notes.fromMapData(response.first);
    }
    return null ;
  }

}