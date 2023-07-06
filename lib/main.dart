import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quotes_app/utils/theme.dart';
import 'package:quotes_app/views/Components/add_component.dart';
import 'package:quotes_app/views/Components/library_component.dart';
import 'package:quotes_app/views/Components/menu_component.dart';
import 'package:quotes_app/views/Components/quotes_component.dart';
import 'package:quotes_app/views/screens/Intro_page.dart';
import 'package:quotes_app/views/screens/Intro_page1.dart';
import 'package:quotes_app/views/screens/Intro_page2.dart';
import 'package:quotes_app/views/screens/creations_page.dart';
import 'package:quotes_app/views/screens/details_page.dart';
import 'package:quotes_app/views/Components/home_component.dart';
import 'package:quotes_app/views/screens/favourite_page.dart';
import 'package:quotes_app/views/screens/home_page.dart';
import 'package:quotes_app/views/screens/privacy_policy.dart';
import 'package:quotes_app/views/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isIntroVisited = prefs.getBool('isIntroVisited') ?? false;

  runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: (isIntroVisited) ? '/' : 'Intro_page',
        getPages: [
          GetPage(name: '/', page: () => SplashScreen(),),
          GetPage(name: '/Intro_page', page: () => IntroPage(),),
          GetPage(name: '/Intro_page1', page: () => IntroPage1(),),
          GetPage(name: '/Intro_page2', page: () => IntroPage2(),),
          GetPage(name: '/home_page', page: () => HomePage(),),
          GetPage(name: '/details_page', page: () => DetailsPage(),),
          GetPage(name: '/home_component', page: () => HomeComponent(),),
          GetPage(name: '/quotes_component', page: () => QuotesComponent(),),
          GetPage(name: '/add_component', page: () => AddComponent(),),
          GetPage(name: '/library_component', page: () => LibraryComponent(),),
          GetPage(name: '/menu_component', page: () => MenuComponent(),),
          GetPage(name: '/favourite_page', page: () => FavouritePage(),),
          GetPage(name: '/creations_page', page: () => CreationsPage(),),
          GetPage(name: '/privacy_policy', page: () => PrivacyPolicy(),),
        ],
      )
  );
}