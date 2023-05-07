import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/Provider/Provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:restaurant/shared/shared_preferences.dart';

class Dropdown_Provider extends StatelessWidget {
  const Dropdown_Provider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var MM = Provider.of<Provider_Languages>(context, listen: true ) ;
    return
      ListTile(
        leading: PopupMenuButton<String>(
          icon: const Icon(
            Icons.expand_more_rounded,
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap:() async {
                  MM.changeLanguage('en') ;
                  await SharedPref().saveLanguage(language: 'en');
                },
                height: 25,
                child: const Text(
                  'en',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold ,
                  ),
                ),
              ),
              PopupMenuItem(
                onTap:()async {
                  MM.changeLanguage('ar') ;
                  await SharedPref().saveLanguage(language: 'ar');
                },
                height: 25,
                child: const Text(
                  'ar',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold ,
                  ),
                ),
              ),
            ];
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.lang ,
        ),
      );
  }
}
