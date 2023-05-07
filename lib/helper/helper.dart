import 'package:flutter/material.dart';

mixin Helper{
  void showSnackBar(BuildContext context,String masseg ){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
      content: Text(masseg),
      duration:const Duration(seconds: 2),
      backgroundColor: Colors.blue,
    ));
  }
}