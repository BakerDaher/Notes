import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget({
    // لا يترك فارغ
    required this.hint,
    required this.tet,
    required this.icon,
    // يترك فارغا عادي
    this.icon2,
    this.textEditingController,
    this.ve_iw ,
    this.error ,
    Key? key,
  }) : super(key: key);

  String hint;
  TextInputType tet;
  IconData icon;

  IconData? icon2;

  TextEditingController? textEditingController;
  bool ?ve_iw;
  String ? error ;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      keyboardType: widget.tet,
      // maxLines:30 ,
      maxLength: 30,
      //obscureText: ve_iw ??= false ,
      //=>> ve_iw == null ? false : ve_iw
      obscuringCharacter: '*',
      cursorHeight: 30,
      cursorWidth: 3,
      decoration: InputDecoration(
        errorText: widget.error ,
        //icon: Icon(Icons.account_box),
        prefixIcon: Icon(widget.icon),
        counterText: '',
        hintText: widget.hint,
        hintStyle: const TextStyle(
          fontSize: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 4,
            )),
      ),
    );
  }
}
