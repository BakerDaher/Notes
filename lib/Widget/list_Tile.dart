import 'package:flutter/material.dart';

class List_Tile extends StatelessWidget {
   List_Tile({
    required this.icon,
    required this.onTap,
    required this.text ,
    Key? key}) : super(key: key);

  IconData icon ;
  Function() onTap;
  String text ;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap ,
      leading: Icon(icon),
      title: Text(text),
    );
  }
}
