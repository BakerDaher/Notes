import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/Provider/notes_Provider.dart';
import 'package:restaurant/Screen/new_Notes.dart';
import 'package:restaurant/model/notes.dart';

class AllNotes extends StatefulWidget {
  const AllNotes({Key? key}) : super(key: key);

  @override
  State<AllNotes> createState() => _AllNotesState();
}

class _AllNotesState extends State<AllNotes> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: Consumer<NotesProvider>(
        builder: (context, NotesProvider value, child){
          if (value.allNotes.isNotEmpty) {
            return ListView.builder(
              itemCount: value.allNotes.length ,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin:  const EdgeInsets.symmetric(vertical: 7.5),
                  padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 7),
                  decoration: BoxDecoration(
                    //color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.blueGrey,
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff57C9EFFF),
                        Colors.lightBlueAccent,
                        Colors.blue,
                        Color(0xff215CF3FF),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ListTile(
                    onTap: (){
                      // go new_notes بطريقة اخرى مع تمرير parameter لل widget
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=> NewNotes(
                          note: value.allNotes[index] ,
                        )),
                      );
                    },
                    title: Text(value.allNotes[index].title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    subtitle: Text(value.allNotes[index].title,style: TextStyle(fontSize: 18),),
                    trailing: IconButton(
                      onPressed: ()async{
                        await delete(value.allNotes[index].id) ;
                      },
                      icon: Icon(Icons.delete , color: Colors.red,),
                    ),
                    leading: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: value.allNotes[index].import ,
                      onChanged: (bool? val) async{
                        await update(value.allNotes[index] , val! ) ;
                      },
                    ),
                    textColor: Colors.white,
                  ),
                );
              },
            );
          }
          else{
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.warning , size: 70,color: Colors.indigoAccent,),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.not ,
                    style: const TextStyle(fontSize: 24) ,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Color im CheckBox ---------------------------------------------
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  Future<void> delete(int id) async {
    bool deleted = await Provider.of<NotesProvider>(context,listen: false).delete(id: id) ;
    if( deleted ){
      await ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Deleted'),
          duration:Duration(seconds: 2),
          backgroundColor: Colors.blue,
        ),
      );
    }else{
      await ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not Deleted > "Error" '),
          duration:Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<bool> update(Notes note , bool val ) async{
    note.import = val ;
    bool saved = await Provider.of<NotesProvider>(context,listen: false).update(note: note ) ;
    return saved ;
  }
}
