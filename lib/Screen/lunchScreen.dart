import 'package:flutter/material.dart';
import 'package:restaurant/shared/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  // ignore: must_call_super
  void initState() {
    Future.delayed( Duration(seconds: 2) , () {
       String rout = SharedPref().Login? '/home_screen' :'/Login_Screen' ;
       Navigator.pushReplacementNamed(context, rout ) ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent,
                    Colors.white,
                    Colors.blue,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize:  MainAxisSize.min,
              children:[
                Image.asset('images/logo.png',width: 100,height: 100,),
                const SizedBox(
                  height: 20,
                ),
                Text(AppLocalizations.of(context)!.lunch,
                  style:  const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ) ,
          ),
        ],
      ),
    );
  }
}
