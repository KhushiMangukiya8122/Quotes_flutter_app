import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../controller/attributes_controller.dart';
import '../../controller/setting_controller.dart';
import '../../controller/wallpaper_controller.dart';
import '../../modals/quotes_database_model.dart';
import '../../utils/atributes.dart';
import 'dart:io';
import '../../utils/list.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  AtributesController atributesController = Get.put(AtributesController());
  SettingsController settingsController = Get.put(SettingsController());
  WallpeparController wallpeparController = Get.put(WallpeparController());

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();

    atributesController.getCategoryName(
      val: atributesController.atributesModel.categoryName,
    );
  }

  List<Color> containerColors = [];

  void changeGradientColor(int index) {
    setState(() {
      if (containerColors.length <= index) {
        containerColors.add(getRandomColor());
      } else {
        containerColors[index] = getRandomColor();
      }
    });
  }

  Color getRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
        .withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AtributesController>(builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              atributesController.atributesModel.categoryName,
              style: TextStyle(
                fontSize: heigth * 0.025,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          body: Screenshot(
            controller: screenshotController,
            child: Container(
              height: heigth,
              width: width,
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
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => changeGradientColor(index),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        containerColors.length > index
                                            ? containerColors[index]
                                            : Colors.red,
                                        Colors.blue,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(atributesController.atributesModel.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: Get.height * 0.76,
                                  width: Get.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Center(
                                      child: Text(
                                        data[i].quotes,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Clipboard.setData(
                                          ClipboardData(
                                            text: data[index].quotes,
                                          ),
                                        ).then(
                                          (value) => Get.snackbar(
                                              "Quote", "Successfully Copy",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor:
                                                  Colors.grey.withOpacity(0.5),
                                              duration:
                                                  const Duration(seconds: 3),
                                              animationDuration:
                                                  const Duration(seconds: 1)),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.copy,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.snackbar("Quote",
                                            "Successfully download your Gallery",
                                            snackPosition:
                                            SnackPosition.BOTTOM,
                                            backgroundColor:
                                            Colors.grey.withOpacity(0.5),
                                            duration:
                                            const Duration(seconds: 3),
                                            animationDuration:
                                            const Duration(seconds: 1));
                                      },
                                      icon: Icon(
                                        Icons.download,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.snackbar(
                                            "Quote", "Successfully Save to Your Favourite",
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor:
                                            Colors.grey.withOpacity(0.5),
                                            duration: const Duration(seconds: 3),
                                            animationDuration:
                                            const Duration(seconds: 1));
                                      },
                                      icon: Icon(
                                        Icons.favorite_border,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.toNamed('/creations_page',
                                            arguments: data[i].quotes);
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        screenshotController
                                            .capture(
                                                delay:
                                                    Duration(milliseconds: 10))
                                            .then((capturedImage) async {
                                          final tempDir =
                                              await getTemporaryDirectory();
                                          final file = await File(
                                                  "${tempDir.path}/${atributesController.atributesModel.image.split("/images")[1].split("/")[2]}")
                                              .create();

                                          print("=======================");
                                          print("${file.path}");
                                          print("=======================");
                                          file.writeAsBytesSync(
                                              capturedImage as List<int>);

                                          Share.shareFiles(['${file.path}']);
                                        }).catchError((onError) {
                                          print(onError);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.share,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
