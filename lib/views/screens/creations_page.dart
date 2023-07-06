import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../controller/attributes_controller.dart';
import '../../modals/quotes_database_model.dart';
import '../../utils/atributes.dart';
import '../../utils/list.dart';

class CreationsPage extends StatefulWidget {
  const CreationsPage({Key? key}) : super(key: key);

  @override
  State<CreationsPage> createState() => _CreationsPageState();
}

class _CreationsPageState extends State<CreationsPage> {
  AtributesController atributesController = Get.put(AtributesController());
  final ScreenshotController screenshotController = ScreenshotController();

  Color selectedBackgroundColor = Colors.grey;
  bool showImages = false;

  @override
  Widget build(BuildContext context) {
    // final quote = Get.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text("Creations Page"),
      ),
      body: FutureBuilder<List<QuotesDatabaseModel>?>(
        future: getAllQuotes!,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<QuotesDatabaseModel>? data = snapshot.data;
            if (data == null || data.isEmpty) {
              return Center(
                child: Text("NO DATA AVAILABLE"),
              );
            } else {
              final quoteModel = data.firstWhere(
                (quoteModel) => quoteModel.quotes == "ABC",
                orElse: () =>
                    QuotesDatabaseModel(id: null, quotes: '', author: ''),
              );
              return Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Screenshot(
                        controller: screenshotController,
                        child: Container(
                          height: Get.height * 0.4,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: selectedBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage(
                                  atributesController.atributesModel.image,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                "ABC",
                                style: TextStyle(
                                  color: selectedFontColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: textSize,
                                  letterSpacing: textLineSpace,
                                  height: textLineSpace + verticalSpacing,
                                  fontFamily: googleFonts[currentFontIndex],
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: "",
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
                              onPressed: () async {
                                await Share.share("ABC");
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: Get.height * 0.08,
                                width: Get.width * 0.4,
                                child: Center(
                                  child: Text(
                                    "Font Size",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (textSize >= 11) {
                                          textSize = textSize - 1.0;
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: Get.height * 0.05,
                                      width: Get.width * 0.1,
                                      decoration: (BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                      child: const Icon(Icons.remove),
                                    ),
                                  ),
                                  SizedBox(width: Get.width * 0.03),
                                  Text(
                                    "$textSize",
                                    style: TextStyle(
                                      fontSize: textSize,
                                    ),
                                  ),
                                  SizedBox(width: Get.width * 0.03),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (textSize <= 29) {
                                          textSize = textSize + 1.0;
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: Get.height * 0.05,
                                      width: Get.width * 0.1,
                                      decoration: (BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                      child: const Icon(Icons.add),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: [
                              Container(
                                height: Get.height * 0.08,
                                width: Get.width * 0.4,
                                child: Center(
                                  child: Text(
                                    "Font Line Space",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (verticalSpacing > 0.1) {
                                          verticalSpacing -= 0.1;
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: Get.height * 0.05,
                                      width: Get.width * 0.1,
                                      decoration: (BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                      child: const Icon(Icons.remove),
                                    ),
                                  ),
                                  SizedBox(width: Get.width * 0.05),
                                  Text(verticalSpacing.toStringAsFixed(1)),
                                  SizedBox(width: Get.width * 0.03),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        verticalSpacing += 0.1;
                                      });
                                    },
                                    child: Container(
                                      height: Get.height * 0.05,
                                      width: Get.width * 0.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Icon(Icons.add),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: Get.height * 0.08,
                                width: Get.width * 0.4,
                                child: Center(
                                  child: Text(
                                    "Font Style",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentFontIndex = (currentFontIndex + 1) %
                                        googleFonts.length;
                                  });
                                },
                                child: Container(
                                  height: Get.height * 0.05,
                                  width: Get.width * 0.4,
                                  decoration: (BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                                  child: Center(
                                    child: Text(
                                      "Font Style",
                                      style: TextStyle(
                                        fontSize: textSize,
                                        fontFamily:
                                            googleFonts[currentFontIndex],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: [
                              Container(
                                height: Get.height * 0.08,
                                width: Get.width * 0.4,
                                child: Center(
                                  child: Text(
                                    "Font Color",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.bottomSheet(
                                        Container(
                                          height: Get.height * 0.35,
                                          padding: const EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Select Color",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      icon: const Icon(
                                                        Icons.close,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: GridView.builder(
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4,
                                                    mainAxisSpacing: 8.0,
                                                    crossAxisSpacing: 8.0,
                                                  ),
                                                  itemCount: Fontcolors.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedFontColor =
                                                              Fontcolors[index];
                                                        });
                                                        Get.back();
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Fontcolors[index],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: Get.height * 0.05,
                                      width: Get.width * 0.1,
                                      child: const Icon(Icons.color_lens),
                                    ),
                                  ),
                                  Text(
                                    "Font Color",
                                    style: TextStyle(
                                      color: selectedFontColor,
                                      fontFamily: googleFonts[currentFontIndex],
                                      fontSize: textSize,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: Get.height * 0.08,
                        width: Get.width * 0.5,
                        child: Center(
                          child: Text(
                            "Background Color",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                Container(
                                  height: Get.height * 0.35,
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Select Color",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            OutlinedButton(
                                              onPressed: () {
                                                Get.toNamed('/add_component');
                                              },
                                              child: Text(
                                                "Select Image",
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  Get.back();
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.close,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            mainAxisSpacing: 8.0,
                                            crossAxisSpacing: 8.0,
                                          ),
                                          itemCount: containerColor.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedBackgroundColor =
                                                      containerColor[index];
                                                  showImages = false;
                                                });
                                                Get.back();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: containerColor[index],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: Get.height * 0.05,
                              width: Get.width * 0.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Icon(Icons.color_lens),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                              color: selectedBackgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
