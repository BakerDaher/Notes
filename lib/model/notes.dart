class Notes{
  late int id;
  late String title;
  late String info ;
 // late String note ;
  late int user_id;
  late bool import = false ;

  Notes() ;
  // SaveData in Map >>> to insert D.B >> List<Map>
  // يتم استعمال الميثود كما هيا مع ماب المرجعة و وضعها في ميتود الإنسيرت لانه يدخل ك ماب
  // D.B to Model
  Map<String , dynamic> toMap(){
    Map<String , dynamic> saveData = <String , dynamic>{} ;
    saveData['title'] = title ;
    saveData['info'] = info ;
    //saveData['note'] = note ;
    saveData['user_id'] = user_id ;
    saveData['import'] = import ? 1 : 0 ;
    return saveData ;
  }

  // fromMapData in Map >>> in readData D.B >> List<Map>
  // ندخل للميثود مخرجات الريد في الداتا بيز
  // Model to D.B
  Notes.fromMapData(Map<String , dynamic> rowData){
    id = rowData['id'] ;
    title = rowData['title'] ;
    info = rowData['info'];
    //note = rowData['note'];
    user_id = rowData['user_id'] ;
    import = rowData['import'] == 1 ? true : false ;
  }
}