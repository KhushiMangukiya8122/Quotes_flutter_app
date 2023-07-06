// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
//
// double heigth = Get.height;
// double width = Get.width;
//
// final data = GetStorage();


import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import '../modals/category_database_model.dart';
import '../modals/quotes_database_model.dart';

double heigth = Get.height;
double width = Get.width;

final data = GetStorage();

final scaffoldKey = GlobalKey<ScaffoldState>();

var textSize = 14.0;
var verticalSpacing = 1.0;
var textLineSpace = 1.0;
Color selectedFontColor = Colors.white;

Future<List<QuotesDatabaseModel>>? getAllQuotes;
Future<List<CategoryDatabaseModel>>? getAllCategory;

