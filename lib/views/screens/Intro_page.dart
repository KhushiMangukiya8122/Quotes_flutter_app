import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/v1.png",
                  ),
                ),
              ),
            ),
            Text(
              "Browse 90000+ unique quotes \n        from 120+ categories",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xff0E2954),
              ),
            ),
            FloatingActionButton(
              onPressed: () async {

                SharedPreferences prefs = await SharedPreferences.getInstance();

                await prefs.setBool('isIntroVisited', true);

                Get.toNamed('/Intro_page1');
              },
              child: Icon(
                Icons.navigate_next,
              ),
            )
          ],
        ),
      ),
      backgroundColor: Color(0xff1F6E8C),
    );
  }
}
