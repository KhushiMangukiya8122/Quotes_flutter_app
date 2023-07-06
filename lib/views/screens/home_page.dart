import 'package:flutter/material.dart';
import '../Components/add_component.dart';
import '../Components/home_component.dart';
import '../Components/library_component.dart';
import '../Components/menu_component.dart';
import '../Components/quotes_component.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController pageController = PageController();

  int initialval = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  PageView(
          controller: pageController,
          pageSnapping: true,
          scrollDirection: Axis.horizontal,
          onPageChanged: (val) {
            setState(() {
              initialval = val;
            });
          },
          children: [
            HomeComponent(),
            QuotesComponent(),
            AddComponent(),
            LibraryComponent(),
            MenuComponent(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.add_to_photos),
              label: "Quotes",
            ),
            NavigationDestination(
              icon: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/add_component');
                },
                child: Icon(Icons.add),
              ),
              label: "",
            ),
            NavigationDestination(
              icon: Icon(Icons.library_books),
              label: "Library",
            ),
            NavigationDestination(
              icon: Icon(Icons.menu),
              label: "Menu",
            ),
          ],
          selectedIndex: initialval,
          onDestinationSelected: (val) {
            setState(() {
              initialval = val;
              pageController.animateToPage(
                initialval,
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            });
          },
        ),
    );
  }
}
