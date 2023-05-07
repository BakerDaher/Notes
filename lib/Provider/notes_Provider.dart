import 'package:flutter/material.dart' ;
import 'package:restaurant/Controller/notes_controller.dart' ;
import 'package:restaurant/model/notes.dart' ;

class NotesProvider extends ChangeNotifier{
  final Note_controller _note_controller = Note_controller() ;
  // Read ALL Notes in Tabel Notes
  List<Notes> allNotes = [] ;
  List<Notes> importNotes = [] ;


  // read not <<< show >>>
  void show_user(int user_id )async{
    // fetch all notes in D.B
    allNotes = await _note_controller.show(user_id) ;
    notifyListeners() ;
  }

  void import_note(){
    // fetch all notes in D.B
    importNotes = allNotes.where((e) => e.import ).toList()  ;
  }

  // Create new Note
  Future<int> create({required Notes note}) async {
    //insert(...) returns the row id of the new inserted record .
    int newRow = await _note_controller.create(note) ;
    if( newRow != 0){
      note.id = newRow ;
      allNotes.add(note) ;
      notifyListeners() ;
    }
    return newRow ;
  }

  // Delete new Note
  Future<bool> delete({required int id }) async {
    bool deleted = await _note_controller.delete(id) ;
    if( deleted ){
      // remove element true extruction
      allNotes.removeWhere((element) => element.id == id) ;
      importNotes.removeWhere((element) => element.id == id) ;
      notifyListeners() ;
    }
    return deleted;
  }

  void deleteImport({required int id }){
    importNotes.removeWhere((element) => element.id == id) ;
  }

  // Update new Note
  Future<bool> update({required Notes note }) async {
    bool updated = await _note_controller.update(note) ;
    if( updated ){
      // update element true extruction
      int index = allNotes.indexWhere((element) => element.id == note.id) ;
      if( index != -1){
        allNotes[index] = note ;
        //importNotes [index] = note ;
      }
      notifyListeners() ;
    }
    return updated ;
  }

  Future<Notes?> get({required int id })async{
    return await _note_controller.showNotes(id) ;
  }


}