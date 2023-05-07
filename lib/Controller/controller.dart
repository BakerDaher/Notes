abstract class DBcontroller<Model>{
  // CRUD >> insert , read , update , delete
  Future<int> create(Model model);
  Future<List<Model>> read();
  Future<bool> update(Model model);
  Future<bool> delete(int id);
  Future<List<Model>> show(int id);
}
