import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quotes_app/modals/quote_modal.dart';
import 'package:quotes_app/controller/database_check_controller.dart';
import 'package:quotes_app/modals/category_database_model.dart';
import 'package:quotes_app/modals/quotes_database_model.dart';
import 'package:flutter/services.dart';
import 'package:quotes_app/utils/list.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modals/quotes_model.dart';
import 'atributes.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  Database? db;

  Future<List<QuotesModel>> LocalJsonDataLoad() async {
    String JsonPath = "assets/json/quotes.json";
    String jsonData = await rootBundle.loadString(JsonPath);

    List decodedList = jsonDecode(jsonData);

    List<QuotesModel> Category =
    decodedList.map((e) => QuotesModel.fromJson(e)).toList();

    return Category;
  }

  Future initDB() async {
    String dbLoaction = await getDatabasesPath();

    String path = join(dbLoaction, 'Quotes.db');

    db = await openDatabase(path, version: 1, onCreate: (db, _) async {
      String query =
          "CREATE TABLE IF NOT EXISTS category(id INTEGER, category_name TEXT NOT NULL);";

      String query2 =
          "CREATE TABLE IF NOT EXISTS quotes(id INTEGER, quote TEXT NOT NULL, author TEXT NOT NULL);";

      await db.execute(query);
      await db.execute(query2);
    });
  }

  Future insertCategory() async {
    await initDB();

    List<QuotesModel> Category = await LocalJsonDataLoad();

    for (int i = 0; i < Category.length; i++) {
      String query = "INSERT INTO category(id, category_name)VALUES(?,?);";
      List args = [
        Category[i].id,
        Category[i].category,
      ];

      await db!.rawInsert(query, args);

    }

    for(int i = 0; i < Category.length; i++) {
      for(int j=0; j< Category[i].quotes.length; j++) {
        String query2 = "INSERT INTO quotes(id,quote,author)VALUES(?,?,?);";
        List args = [
          Category[i].quotes[j].id,
          Category[i].quotes[j].quote,
          Category[i].quotes[j].author,
        ];
        await db!.rawInsert(query2,args);
      }
    }
  }

  Future<List<CategoryDatabaseModel>> fatchAllCategory() async {
    await initDB();
    DataBaseCheckController dataBaseCheckController = DataBaseCheckController();

    if (data.read("isInsert") != true) {
      await insertCategory();

    }

    dataBaseCheckController.InsertInValue();

    String query = "SELECT * FROM category;";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<CategoryDatabaseModel> allCategory =
    res.map((e) => CategoryDatabaseModel.formMap(data: e)).toList();

    return allCategory;
  }

    Future<List<CategoryDatabaseModel>> fetchSearchCategories({required String data})async{
      await initDB();

      String query = "SELECT * FROM category WHERE category_name LIKE '%$data%';";

      List<Map<String, dynamic>> res = await db!.rawQuery(query);

      List<CategoryDatabaseModel> query1 =   res.map((e) => CategoryDatabaseModel.formMap(data: e)).toList();

      return query1;
    }

  Future<List<QuotesDatabaseModel>> fatchAllQuotes({required int id}) async {
    await initDB();

    String query = "SELECT * FROM quotes WHERE id = ?;";
    List args = [id];

    List<Map<String, dynamic>> res = await db!.rawQuery(query, args);


    List<QuotesDatabaseModel> allQuotes =
    res.map((e) => QuotesDatabaseModel.formMap(data: e)).toList();

    return allQuotes;
  }

}


class APIHelper {
  APIHelper._(); //private named constructor
  static final APIHelper apiHelper = APIHelper._();

  Future<QuoteModal?> fetchQuote() async {
    String baseUrl = "http://api.quotable.io/random";
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = jsonDecode(response.body);
      QuoteModal quotesData = QuoteModal.fromMap(decodedData);
      return quotesData;
    }
    return null;
  }
}



