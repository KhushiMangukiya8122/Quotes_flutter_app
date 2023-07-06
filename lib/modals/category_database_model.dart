class CategoryDatabaseModel {
  int id;
  String category_name;


  CategoryDatabaseModel({
    required this.id,
    required this.category_name,
  });

  factory CategoryDatabaseModel.formMap({required Map data}) {
    return CategoryDatabaseModel(
      id: data['id'],
      category_name: data['category_name'],
    );
  }
}