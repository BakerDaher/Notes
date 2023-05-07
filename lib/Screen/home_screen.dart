import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/Provider/notes_Provider.dart';
import 'package:restaurant/Screen/Import_note.dart';
import 'package:restaurant/Screen/all_note.dart';
import 'package:restaurant/Widget/list_Tile.dart';
import 'package:restaurant/shared/shared_preferences.dart';
import 'package:restaurant/Widget/DropdownButton_Provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabControler ;

  @override
  void initState(){
    // TODO: implement initState
    // Data occurs but does not occur in UI
    Provider.of<NotesProvider>(context,listen: false).show_user(SharedPref().id) ;
    _tabControler = TabController(length: 2, vsync: this ) ;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabControler.dispose() ;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/info_Screen');
              },
              icon: Icon(Icons.wifi_lock_outlined)),
        ],
        bottom: TabBar(
          controller: _tabControler,
          tabs: const [
            Text("All notes",style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),) ,
            Text("Important Notes",style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),) ,
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Text( SharedPref().Name ),
              ),
              otherAccountsPictures: const [
                CircleAvatar(),
                CircleAvatar(),
                CircleAvatar(),
              ],
              accountName: Text(SharedPref().Name),
              accountEmail: Text(SharedPref().Email),
            ),
            List_Tile(icon: Icons.home, onTap: () {}, text: AppLocalizations.of(context)!.home),
            List_Tile(icon: Icons.settings, onTap: () {}, text: AppLocalizations.of(context)!.setting),
            List_Tile(
                icon: Icons.logout,
                onTap: () async {
                  Navigator.pop(context);
                  await SharedPref().clear();
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pushReplacementNamed(context, '/Login_Screen');
                  });
                },
                text: AppLocalizations.of(context)!.logout),
            const SizedBox(
              height: 9,
            ),
            const Dropdown_Provider(),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabControler ,
        children: const [
          AllNotes(),
          ImportNotes() ,
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context,'/notes_screen') ;
          } ,
          backgroundColor: Colors.indigoAccent,
          child:const Icon(Icons.add,size: 30,),
        ),
      ),
    );
  }
}