class User{
  late int id ;
  late String name ;
  late String email ;
  late String password ;
  late bool login ;

  User() ;

  // SaveData in Map >>> to insert D.B >> List<Map>
  // يتم استعمال الميثود كما هيا مع ماب المرجعة و وضعها في ميتود الإنسيرت لانه يدخل ك ماب
  Map<String , dynamic> toMap(){
    Map<String , dynamic> saveData = <String , dynamic>{} ;
    saveData['name'] = name ;
    saveData['email'] = email ;
    saveData['password'] = password ;
    return saveData ;
  }

  // fromMapData in Map >>> in readData D.B >> List<Map>
  // ندخل للميثود مخرجات الريد في الداتا بيز
  // كل مرة يستعي اوبجيكت جديد
  User.fromMapData(Map<String , dynamic> rowData){
    id = rowData['id'] ;
    name = rowData['name'] ;
    email = rowData['email'];
    password = rowData['password'];
  }
}