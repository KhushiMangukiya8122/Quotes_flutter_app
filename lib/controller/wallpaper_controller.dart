
import 'package:get/get.dart';
import '../modals/wallpaper_model.dart';

class WallpeparController extends GetxController {
  WallpeparModel wallpeparModel = WallpeparModel();

  getIndex({required int index}) {
    wallpeparModel.indexCheck = index;
    update();
  }
}