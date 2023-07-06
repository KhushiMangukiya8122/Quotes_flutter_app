import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quotes_app/modals/category_database_model.dart';
import 'package:quotes_app/utils/dbHelper.dart';
import 'package:quotes_app/utils/list.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../controller/attributes_controller.dart';
import '../../controller/setting_controller.dart';
import '../../controller/wallpaper_controller.dart';
import '../../modals/quote_modal.dart';
import '../../utils/atributes.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({Key? key}) : super(key: key);

  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
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

  AtributesController atributesController = Get.put(AtributesController());
  SettingsController settingsController = Get.put(SettingsController());
  WallpeparController wallpeparController = Get.put(WallpeparController());

  ScreenshotController screenshotController = ScreenshotController();

  QuoteModal? quote;

  @override
  void initState() {
    super.initState();
    getAllCategory = DBHelper.dbHelper.fatchAllCategory();
    fetchRandomQuote();
  }

  Future<void> fetchRandomQuote() async {
    quote = await APIHelper.apiHelper.fetchQuote();
    if (quote != null) {
      await saveQuoteToSharedPreferences(quote!);
    }
    setState(() {});
  }

  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getAllCategory,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<CategoryDatabaseModel>? data = snapshot.data;

            if (data == null || data.isEmpty) {
              return Center(
                child: Text("NO DATA AVAILABLE"),
              );
            } else {
              return IndexedStack(
                index: initialIndex,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            height: 250,
                            width: Get.width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              image: DecorationImage(
                                image:
                                AssetImage("assets/images/quote.gif"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Popular",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    initialIndex = 1;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "See More",
                                    ),
                                    Icon(
                                      Icons.expand_more,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...List.generate(
                                  5,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            atributesController
                                                .getCategoryId(
                                                    val: data[index].id);
                                            atributesController
                                                .getCategoryName(
                                                    val: data[index]
                                                        .category_name);

                                            getAllQuotes = DBHelper.dbHelper
                                                .fatchAllQuotes(
                                                    id: data[index].id);

                                            Get.toNamed('/details_page');
                                          },
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "${popular[index]['image']}"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        Text("${popular[index]['name']}"),
                                      ],
                                    ),
                                  ),
                                ).toList(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Random Quote",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    fetchRandomQuote();
                                  });
                                },
                                child: Text(
                                  "Next",
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => changeGradientColor(index),
                            child: Container(
                              height: Get.height * 0.35,
                              width: Get.width,
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
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Center(
                                  child: Text(
                                    quote?.content ??
                                        "Don\'t talk about what you have done or what you are going to do.",
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: Get.height * 0.08,
                            width: Get.width,
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(
                                        text: quote?.content ?? "",
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
                                    Get.snackbar("Quote",
                                        "Successfully Save to Your Favourite",
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
                                    Icons.favorite_border,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await Share.share(quote?.content ?? "");
                                  },
                                  icon: Icon(
                                    Icons.share,
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Motivational",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...List.generate(
                                  5,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            atributesController
                                                .getCategoryId(
                                                    val:
                                                        data[index + 5].id);
                                            atributesController
                                                .getCategoryName(
                                                    val: data[index + 5]
                                                        .category_name);

                                            getAllQuotes = DBHelper.dbHelper
                                                .fatchAllQuotes(
                                                    id: data[index + 5].id);

                                            Get.toNamed('/details_page');
                                          },
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "${motivational[index]['image']}"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        Text(
                                            "${motivational[index]['name']}"),
                                      ],
                                    ),
                                  ),
                                ).toList(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Occassional",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...List.generate(
                                  5,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            atributesController
                                                .getCategoryId(
                                                    val: data[index + 10]
                                                        .id);
                                            atributesController
                                                .getCategoryName(
                                                    val: data[index + 10]
                                                        .category_name);

                                            getAllQuotes = DBHelper.dbHelper
                                                .fatchAllQuotes(
                                                    id: data[index + 10]
                                                        .id);

                                            Get.toNamed('/details_page');
                                          },
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "${occassional[index]['image']}"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        Text(
                                            "${occassional[index]['name']}"),
                                      ],
                                    ),
                                  ),
                                ).toList(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Feelings",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...List.generate(
                                  5,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            atributesController
                                                .getCategoryId(
                                                    val: data[index + 15]
                                                        .id);
                                            atributesController
                                                .getCategoryName(
                                                    val: data[index + 15]
                                                        .category_name);

                                            getAllQuotes = DBHelper.dbHelper
                                                .fatchAllQuotes(
                                                    id: data[index + 15]
                                                        .id);

                                            Get.toNamed('/details_page');
                                          },
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "${feelings[index]['image']}"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        Text("${feelings[index]['name']}"),
                                      ],
                                    ),
                                  ),
                                ).toList(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Family",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...List.generate(
                                  5,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            atributesController
                                                .getCategoryId(
                                                    val: data[index + 20]
                                                        .id);
                                            atributesController
                                                .getCategoryName(
                                                    val: data[index + 20]
                                                        .category_name);

                                            getAllQuotes = DBHelper.dbHelper
                                                .fatchAllQuotes(
                                                    id: data[index + 20]
                                                        .id);

                                            Get.toNamed('/details_page');
                                          },
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "${family[index]['image']}"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        Text("${family[index]['name']}"),
                                      ],
                                    ),
                                  ),
                                ).toList(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Moments",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...List.generate(
                                  5,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            atributesController
                                                .getCategoryId(
                                                    val: data[index + 25]
                                                        .id);
                                            atributesController
                                                .getCategoryName(
                                                    val: data[index + 25]
                                                        .category_name);

                                            getAllQuotes = DBHelper.dbHelper
                                                .fatchAllQuotes(
                                                    id: data[index + 25]
                                                        .id);

                                            Get.toNamed('/details_page');
                                          },
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "${moments[index]['image']}"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        Text("${moments[index]['name']}"),
                                      ],
                                    ),
                                  ),
                                ).toList(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Objects",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...List.generate(
                                  5,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            atributesController
                                                .getCategoryId(
                                                    val: data[index + 30]
                                                        .id);
                                            atributesController
                                                .getCategoryName(
                                                    val: data[index + 30]
                                                        .category_name);

                                            getAllQuotes = DBHelper.dbHelper
                                                .fatchAllQuotes(
                                                    id: data[index + 30]
                                                        .id);

                                            Get.toNamed('/details_page');
                                          },
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "${objects[index]['image']}"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        Text("${objects[index]['name']}"),
                                      ],
                                    ),
                                  ),
                                ).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Search here...."),
                          onChanged: (val) async {
                            setState(() {
                              getAllCategory = DBHelper.dbHelper
                                  .fetchSearchCategories(data: val);
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Quotes Category",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  initialIndex = 0;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "See",
                                  ),
                                  Icon(
                                    Icons.expand_less,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(
                                data.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: GestureDetector(
                                    onTap: () {
                                      atributesController.getCategoryId(
                                          val: data[index].id);
                                      atributesController.getCategoryName(
                                          val: data[index].category_name);

                                      getAllQuotes = DBHelper.dbHelper
                                          .fatchAllQuotes(id: data[index].id);

                                      Get.toNamed('/details_page');
                                    },
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${data[index].category_name}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .primaries[index % 18].shade400,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ).toList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
