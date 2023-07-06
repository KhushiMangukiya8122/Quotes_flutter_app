import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuComponent extends StatefulWidget {
  const MenuComponent({Key? key}) : super(key: key);

  @override
  State<MenuComponent> createState() => _MenuComponentState();
}

class _MenuComponentState extends State<MenuComponent> {
  bool isnotification = false;
  bool iswidget = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: Get.height * 0.3,
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/nature.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                "Quotes Status Sayings",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          ListTile(
            trailing: CupertinoSwitch(
              value: isnotification,
              activeColor: Color(0xff1F6E8C),
              onChanged: (val) {
                setState(() {
                  isnotification = !isnotification;
                });
              },
            ),
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
          ),
          ListTile(
            trailing: CupertinoSwitch(
              value: iswidget,
              activeColor: Color(0xff1F6E8C),
              onChanged: (val) {
                setState(() {
                  iswidget = !iswidget;
                });
              },
            ),
            onTap: () {
              setState(() {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Text(
                        "Background Widget Update",
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              "Things do not happens. Things are made to happen."),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: Text("Dissmiss"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: Text("ok"),
                              ),
                            ],
                          ),
                        ],
                      )),
                );
              });
            },
            leading: Icon(Icons.widgets),
            title: Text("Widgets"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: Text(
                            "Use can contect us for anything like request a feature, report a bug, need help or have a question.",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  await launchUrl(Uri.parse("mailto: "),);
                                },
                                child: Text("ok"),
                              ),
                            ],
                          ),
                      ),
                    );
                  });
                },
                child: Container(
                  height: 100,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                      ),
                      Text(
                        "Contact Us",
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await Share.share(
                      "mailto: ");
                },
                child: Container(
                  height: 100,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share,
                      ),
                      Text(
                        "Share",
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/privacy_policy');
                },
                child: Container(
                  height: 100,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.privacy_tip,
                      ),
                      Text(
                        "Privacy Policy",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.sd_card_alert),
            title: Text("Quotes for you"),
          ),
          ListTile(
            leading: Icon(Icons.account_tree),
            title: Text("System Theme"),
          ),
        ],
      ),
    );
  }
}