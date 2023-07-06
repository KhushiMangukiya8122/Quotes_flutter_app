import 'package:flutter/material.dart';
import 'package:quotes_app/modals/quotes_model.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {

  List<QuotesModel> allQuotes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (allQuotes.isNotEmpty) ? ListView.builder(
        itemBuilder: (context, i) => ListTile(
          title: Text("${allQuotes[i].quotes}"),
        ),
        itemCount: allQuotes.length,
      ) : Column(
        children: [
          Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/favourite.png",),
              ),
            ),
          ),
          Text(
            "This is where you will see your \n                 liked quotes.",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}
