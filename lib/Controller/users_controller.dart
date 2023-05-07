import 'package:restaurant/Controller/controller.dart';
import 'package:restaurant/model/user.dart';
import 'package:sqflite/sqflite.dart';
import '../SQL/sqldb.dart';

class User_controller extends DBcontroller<User>{
  Future<Database?> mydb = sqlDB().db  ;
  Database? db ;
  @override
  Future<int> create(User model) async {
    // TODO: implement creat
    db = await mydb ;
    if((await checkIfExist(email: model.email)).isNotEmpty){
      return -1 ; // user is Exist
    }else{
      //insert(...) returns the row id of the new inserted record.
      int response = await db!.insert("users", model.toMap()) ;
      return response ;
    }
  }

  @override
  Future<bool> delete(int id) async {
    // TODO: implement delete
    db = await mydb ;
    int response = await db!.delete("users" ,where: 'id=?',whereArgs: [id]);
    return response == 1 ;
  }

  @override
  Future<List<User>> read() async {
    // TODO: implement read
    db = await mydb ;
    List<Map<String,dynamic>> response = await db!.query("users") ;
    if( response.isNotEmpty){
      // بعد فرط الليست الى ماب من يوزر يحولهم اللى ليست
      return response.map((e) => User.fromMapData(e)).toList();
    }
    return [] ;
  }

  @override
  Future<List<User>> show(int id) async{
    // TODO: implement show
    db = await mydb ;
    List<Map<String,dynamic>> response = await db!.query("users",where: 'id=?',whereArgs: [id]) ;
    if( response.isNotEmpty){
      // بعد فرط الليست الى ماب من يوزر يحولهم اللى ليست
      return response.map((e) => User.fromMapData(e)).toList();
    }
    return [] ;
  }

  @override
  Future<bool> update(User model) async {
    // TODO: implement update
    db = await mydb ;
    int response = await db!.update("users",  model.toMap() , where:'id=?' ,whereArgs: [model.id] ) ;
    return response == 1 ;
  }

  Future<User?> login({required String email,required String password}) async{
    // TODO: implement login
    db = await mydb ;
    List<Map<String,dynamic>> response = await db!.query("users",where: 'email=? AND password = ?',whereArgs: [email , password ]) ;
    if(response.isNotEmpty ){
      return User.fromMapData(response.first) ;
    }
    return null ;
  }

  Future<List<Map<String,dynamic>> > checkIfExist({required String email}) async{
    // TODO: implement login
    db = await mydb ;
    List<Map<String,dynamic>> response = await db!.query("users",where: 'email=? ',whereArgs: [email]) ;
    return response;
  }

  Future<List<Map<String,dynamic>>> updatePass({required String email, required String password }) async {
    // TODO: implement update
    db = await mydb ;
    List<Map<String,dynamic>> response = await checkIfExist(email: email) ;
    return response;
  }
}