import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/Provider/notes_Provider.dart';
import 'package:restaurant/Provider/user_Provider.dart';
import 'package:restaurant/Screen/change_Passwerd.dart';
import 'package:restaurant/Screen/login.dart';
import 'package:restaurant/Screen/lunchScreen.dart';
import 'package:restaurant/Screen/new_Notes.dart';
import 'package:restaurant/Screen/singup_screen.dart';
import 'package:restaurant/Screen/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:restaurant/Provider/Provider.dart';
import 'package:restaurant/shared/shared_preferences.dart';

void main() async {
  /*
  * Returns an instance of the WidgetsBinding ,
  * creating and initializing it if necessary .
  * If one is created, it will be a WidgetsFlutterBinding .
  * If one was previously initialized ,
  * then it will at least implement WidgetsBinding .
  */
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref().initPreferences();
  //Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Provider_Languages>(create: (_)=> Provider_Languages() ,),
        ChangeNotifierProvider<UserProvider>(create: (_)=> UserProvider() ,),
        ChangeNotifierProvider<NotesProvider>(create: (_)=> NotesProvider() ,),

      ],
      child: Material_App(),
    );
  }
}

class Material_App extends StatelessWidget {
   Material_App({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // language 
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar') ,
        Locale('en') ,
      ], // map in
      locale: Locale(Provider.of<Provider_Languages>(context).lang) ,
      // screen
      routes: {
        // Key : value
        '/Login_Screen': (context) => const LoginScreen(),
        '/Launch_Screen': (context) => const LaunchScreen(),
        '/singup_screen': (context) => const SignUpScreen(),
        '/home_screen': (context) => HomeScreen(),
        '/notes_screen': (context) => NewNotes(),
        '/change_screen':(context) => change() ,
      },

      debugShowCheckedModeBanner: false,
      // start run
      initialRoute: '/Launch_Screen',
    );
  }
}
