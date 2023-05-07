import 'package:flutter/material.dart';
import 'package:restaurant/Controller/users_controller.dart';
import 'package:restaurant/model/user.dart';
import '../shared/shared_preferences.dart';

class UserProvider extends ChangeNotifier{
  final User_controller _user_controller = User_controller() ;

  // Sing Up
  // true >> insert in the D.B **** false >> account was found in the D.B
  Future<bool> create({required User user}) async{
    int newRow = await _user_controller.create(user) ;
    return newRow > 0 ;
  }

  // Login
  // true >> account was found in the D.B and login **** false >> account was Not found in the D.B
  Future<bool> login({required String email,required String password}) async{
    User ? loggedIn = await _user_controller.login(email: email, password: password) ;
    if(loggedIn != null){
      loggedIn.login = true ;
      await SharedPref().saveAcount(user: loggedIn );
    }
    return loggedIn != null ;
  }

  // update
  Future<bool> update({required String email,required String password}) async{
    List<Map<String,dynamic>> response = await _user_controller.updatePass(email: email, password: password) ;
    if(response.isNotEmpty){
      User user =  User.fromMapData(response.first) ;
      user.password = password ;
      bool update = await _user_controller.update(user) ;
      return update ;
    }else{
      return false ;
    }
  }

  // true >> account was found in the D.B **** false >> account was Not found in the D.B
  Future<bool> checkIfExist({required String email})async{
    return (await _user_controller.checkIfExist(email: email)).isNotEmpty ;
  }
}