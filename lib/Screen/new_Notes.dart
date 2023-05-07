import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/Provider/notes_Provider.dart';
import 'package:restaurant/model/notes.dart';
import 'package:restaurant/shared/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewNotes extends StatefulWidget {
  NewNotes({Key? key , this.note }) : super(key: key);
  Notes ? note ;

  @override
  State<NewNotes> createState() => _NewNotesState();
}

class _NewNotesState extends State<NewNotes> {
  late TextEditingController _textTitle ;
  late TextEditingController _textNotes ;

  @override
  void initState() {
    super.initState();
    _textTitle = TextEditingController(text: widget.note?.title) ;
    _textNotes = TextEditingController(text: widget.note?.info) ;
  }

  @override
  void dispose(){
    super.dispose() ;
    _textNotes.dispose();
    _textTitle.dispose() ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textTitle,
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.title  ,
                      ),

                    ),
                  ),
                  ElevatedButton(
                    onPressed: ()async{
                      await performSave() ;
                    } ,
                    child: Text(AppLocalizations.of(context)!.save ),
                  ) ,
                ],
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _textNotes ,
                minLines: 1,
                maxLines: 100, //or null
                decoration: InputDecoration.collapsed(hintText: AppLocalizations.of(context)!.notes ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  bool check(){
    if(_textTitle.text.isNotEmpty ){
      return true ;
    }
    return false ;
  }

  Future<void> save() async {
    if( await saved() ){
      await ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Success'),
          duration:Duration(seconds: 2),
          backgroundColor: Colors.blue,
        ),
      );
    }else{
      await ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not Success > "Error" '),
          duration:Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<bool> saved() async{
    if(widget.note == null){
      int id = await Provider.of<NotesProvider>(context,listen: false).create(note: note()) ;
      widget.note =  await Provider.of<NotesProvider>(context,listen: false).get(id: id);
      return id != 0 ;
    }else{
      bool saved = await Provider.of<NotesProvider>(context,listen: false).update(note: note() ) ;
      return saved ;
    }
  }

  Notes note(){
    Notes note = Notes() ;

    // if note == null >> id defolt in SQl increment Cannot need لتعريفه
    // if note != null >> id  >> widget.note!.id معرف لذلك يمرر
    // widget.note!.id >> this is id الخاص في النوت الممررة

    if( widget.note!=null ) note.id= widget.note!.id ;
    if(widget.note!=null) note.import = widget.note!.import ;
    note.title = _textTitle.text ;
    note.info = _textNotes.text ;
    note.user_id = SharedPref().id ;
    return note ;
  }

  Future<void> performSave() async {
    if(check()){
      await save() ;
      Future.delayed( Duration(seconds:1) , () {
        Navigator.pop(context) ;
      });

    }else{
      await ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ERROR >> Note Is Empty '),
          duration:Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
