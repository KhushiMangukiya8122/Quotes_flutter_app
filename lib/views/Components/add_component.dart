import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/attributes_controller.dart';
import '../../controller/wallpaper_controller.dart';
import '../../utils/atributes.dart';
import '../../utils/list.dart';

class AddComponent extends StatefulWidget {
  const AddComponent({Key? key}) : super(key: key);

  @override
  State<AddComponent> createState() => _AddComponentState();
}

class _AddComponentState extends State<AddComponent> {

  AtributesController atributesController = Get.find<AtributesController>();
  WallpeparController wallpeparController = Get.find<WallpeparController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Page"),
        backgroundColor: (Get.isDarkMode) ? Color(0xff212832) : Colors.white,
        elevation: 0,
      ),

      backgroundColor: (Get.isDarkMode) ? Color(0xff212832) : Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GetBuilder<WallpeparController>(builder: (_) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              mainAxisExtent: heigth * 0.24,
            ),
            itemCount: Themes.length,
            itemBuilder: (context, i) => GestureDetector(
              onTap: () {
                atributesController.getImage(img: Themes[i]);
                wallpeparController.getIndex(index: i);
                Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(Themes[i]),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: (wallpeparController.wallpeparModel.indexCheck == i)
                      ? CircleAvatar(
                    radius: heigth * 0.015,
                    backgroundColor: (Get.isDarkMode)
                        ? Color(0xff212832)
                        : Colors.white,
                    child: Icon(Icons.check),
                  )
                      : Container(),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
