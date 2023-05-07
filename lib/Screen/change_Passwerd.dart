import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/Widget/TextFieldWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:restaurant/helper/helper.dart';
import '../Provider/user_Provider.dart';

class change extends StatefulWidget {
  const change({Key? key}) : super(key: key);


  @override
  State<change> createState() => _changeState();
}

class _changeState extends State<change> with Helper {
  late TextEditingController _textEditingController1;
  late TextEditingController _textEditingController2;
  late TapGestureRecognizer _tapGestureRecognizer;
  String? _passwordError;
  String? _emailError;

  @override
  void initState() {
    // TODO: implement initState
    _textEditingController1 = TextEditingController();
    _textEditingController2 = TextEditingController();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = goToSignUp;
    //_tapGestureRecognizer.onTap = goToSignUp ;
  }

  void goToSignUp() {
    Navigator.pushNamed(context, '/singup_screen');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController1.dispose();
    _textEditingController2.dispose();
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 150,
            left: 30,
            right: 30,
          ),
          child: Column(
            //Defoult
            //crossAxisAlignment: CrossAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.change1,
                style: GoogleFonts.nunito(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: const Color(0XFF23203F)),
              ),
              const SizedBox(
                height: 50 ,
              ),
              TextFieldWidget(
                icon: Icons.email,
                hint: AppLocalizations.of(context)!.email ,
                tet: TextInputType.emailAddress,
                ve_iw: false,
                error: _emailError,
                textEditingController: _textEditingController1,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFieldWidget(
                icon: Icons.password,
                hint: AppLocalizations.of(context)!.passwerd,
                tet: TextInputType.visiblePassword,
                ve_iw: true,
                error: _passwordError,
                textEditingController: _textEditingController2,
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: ()  async{
                    await _change();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    fixedSize: const Size(400, 50),
                    textStyle: const TextStyle(
                      fontSize: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(
                        width: 3,
                        color: Colors.limeAccent,
                      ),
                    ),
                  ),
                  child:  Text( AppLocalizations.of(context)!.change),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _change() async{
    checkError();
    if(_textEditingController1.text.isNotEmpty &&
        _textEditingController2.text.isNotEmpty) {
      await upData() ;
    }else{
      showSnackBar(context ,'Fount is Empty') ;
    }
  }

  void checkError() {
    setState((){
      _emailError = _textEditingController1.text.isEmpty ? 'Enter Email' : null ;
      _passwordError = _textEditingController2.text.isEmpty ? 'Enter Password' : null ;
    });
  }

  Future<void> upData()async{
    String password = _textEditingController2.text ;
    String email = _textEditingController1.text ;
    bool save = await Provider.of<UserProvider>(context,listen: false).update(email: email , password: password);
    if( save){
      showSnackBar(context ,'Change password Sucsess');
      Future.delayed(Duration(seconds: 1),()async{
        await Navigator.pushReplacementNamed(context, '/Login_Screen' );
      });
    }
    else{
      showSnackBar(context , 'Error in the change password >> Not Fount Email' );
    }
  }
}