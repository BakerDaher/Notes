import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/Widget/TextFieldWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant/helper/helper.dart';
import '../Provider/user_Provider.dart';
import '../model/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with Helper{
  late TextEditingController _textEditingController1;
  late TextEditingController _textEditingController2;
  late TextEditingController _textEditingController3 ;
  String? _emailError;
  String? _passwordError;
  String? _nameError ;

  @override
  void initState() {
    // TODO: implement initState
    _textEditingController1 = TextEditingController();
    _textEditingController2 = TextEditingController();
    _textEditingController3 = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController1.dispose();
    _textEditingController2.dispose();
    _textEditingController3.dispose();
    super.dispose() ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 100,
          ),
          children: [
            Text(
              AppLocalizations.of(context)!.signup_2 ,
              style: GoogleFonts.nunito(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color(0XFF23203F)),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFieldWidget(
              icon: Icons.email,
              hint: AppLocalizations.of(context)!.email,
              tet: TextInputType.emailAddress,
              ve_iw: false,
              error: _emailError,
              textEditingController: _textEditingController1,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFieldWidget(
              icon: Icons.person,
              hint: AppLocalizations.of(context)!.name,
              tet: TextInputType.name,
              ve_iw: true,
              error: _nameError,
              textEditingController: _textEditingController3,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFieldWidget(
              icon: Icons.password,
              hint: AppLocalizations.of(context)!.passwerd ,
              tet: TextInputType.visiblePassword,
              ve_iw: true,
              error: _passwordError,
              textEditingController: _textEditingController2,
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    await performRegister() ;
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.limeAccent,
                      primary: Colors.red),
                  child: Text(
                    AppLocalizations.of(context)!.signup_2,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performRegister()async{
    if(check()){
      Register() ;
    }
  }

  bool check(){
    checkError();
    if( _textEditingController1.text.isNotEmpty &&
        _textEditingController2.text.isNotEmpty &&
        _textEditingController3.text.isNotEmpty ){
      return true ;
    }
    return false ;
  }

  void checkError() {
    setState((){
      _emailError = _textEditingController1.text.isEmpty ? 'Enter Email' : null;
      _passwordError =
      _textEditingController2.text.isEmpty ? 'Enter Password' : null;
      _nameError =
      _textEditingController3.text.isEmpty ? 'Enter Name' : null;
    });
  }

  // SingUp in D.B
  Future<void> Register() async{
    bool Register = await Provider.of<UserProvider>(context,listen: false).create(user: user() ) ;
    if(Register){
      Navigator.pop(context) ;
      showSnackBar(context ,'Account created  ${_textEditingController3.text} ');
    }else{
      showSnackBar(context ,'Account was Found' );
    }
  }

  User user(){
    User user = User() ;
    user.password = _textEditingController2.text ;
    user.email = _textEditingController1.text ;
    user.name = _textEditingController3.text ;
    user.login = false ;
    return user ;
  }
}

