import 'package:quotes_app/modals/database_check_model.dart';
import 'package:quotes_app/utils/atributes.dart';
import 'package:get/get.dart';

class DataBaseCheckController extends GetxController {
  DataBaseCheckModel dataBaseCheckModel = DataBaseCheckModel(isInsert: false);

  InsertInValue()  {
    dataBaseCheckModel.isInsert = true;

    data.write("isInsert", dataBaseCheckModel.isInsert);

    update();
  }
}