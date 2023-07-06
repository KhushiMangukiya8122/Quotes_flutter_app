import 'package:quotes_app/modals/attributes_model.dart';
import 'package:get/get.dart';
import '../utils/atributes.dart';
import '../utils/list.dart';

class AtributesController extends GetxController {
  AtributesModel atributesModel = AtributesModel(
      id: 0, categoryName: "love", image: images[0]);

  getImage({required String img}) {
    atributesModel.image = img;
    update();
  }

  getCategoryId({required int val}) {
    atributesModel.id = val;
    update();
  }

  getCategoryName({required String val}) {
    atributesModel.categoryName = val;
    update();
  }
}