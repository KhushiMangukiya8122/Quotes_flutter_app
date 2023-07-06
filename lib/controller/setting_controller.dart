import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modals/setting_model.dart';

class SettingsController extends GetxController {
  SettingsModel settingsModel = SettingsModel(
      themeMode: false,
      showAuthor: false,
      showcategory: false,
      enableNotifications: false);

  getThemeValue({required bool val}) {
    settingsModel.themeMode = val;

    (settingsModel.themeMode == false)
        ? Get.changeTheme(ThemeData.light(useMaterial3: true))
        : Get.changeTheme(ThemeData.dark(useMaterial3: true));
    update();
  }

  getAuthorValue({required bool val}) {
    settingsModel.showAuthor = val;
    update();
  }

  getCategoryValue({required bool val}) {
    settingsModel.showcategory = val;
    update();
  }

  getNotificationValue({required bool val}) {
    settingsModel.enableNotifications = val;
    update();
  }
}