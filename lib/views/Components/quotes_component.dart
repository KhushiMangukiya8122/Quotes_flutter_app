import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';
import '../../controller/attributes_controller.dart';
import '../../controller/setting_controller.dart';
import '../../controller/wallpaper_controller.dart';
import '../../modals/quotes_database_model.dart';
import '../../utils/atributes.dart';
import 'package:get/get.dart';

class QuotesComponent extends StatefulWidget {
  const QuotesComponent({Key? key}) : super(key: key);

  @override
  State<QuotesComponent> createState() => _QuotesComponentState();
}

class _QuotesComponentState extends State<QuotesComponent> {

  AtributesController atributesController = Get.put(AtributesController());
  SettingsController settingsController = Get.put(SettingsController());
  WallpeparController wallpeparController = Get.put(WallpeparController());
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    // getAllQuotes = DBHelper.dbHelper.fatchAllQuotes(id: 0);

    atributesController.getCategoryName(
        val: atributesController.atributesModel.categoryName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AtributesController>(builder: (_) {
        return Screenshot(
          controller: screenshotController,
          child: Container(
            height: heigth,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(atributesController.atributesModel.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              height: heigth,
              width: width,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      atributesController.atributesModel.categoryName,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: getAllQuotes,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("ERROR : ${snapshot.error}"),
                            );
                          } else if (snapshot.hasData) {
                            List<QuotesDatabaseModel>? data = snapshot.data;

                            if (data == null || data.isEmpty) {
                              return Center(
                                child: Text("No Data Available"),
                              );
                            } else {
                              return CarouselSlider(
                                items: data
                                    .map(
                                      (e) => Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${e.quotes}",
                                        style: GoogleFonts.yaldevi(
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: heigth * 0.035,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                    .toList(),
                                options: CarouselOptions(
                                  height: heigth * 0.75,
                                  viewportFraction: 1,
                                  scrollDirection: Axis.vertical,
                                ),
                              );
                            }
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
