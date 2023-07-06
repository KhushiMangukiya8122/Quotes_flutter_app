import 'package:shared_preferences/shared_preferences.dart';

class QuoteModal {
  String id;
  String content;
  String author;
  String authorSlug;

  QuoteModal({
    required this.id,
    required this.content,
    required this.author,
    required this.authorSlug,
  });

  factory QuoteModal.fromMap(Map<String, dynamic> data) {
    return QuoteModal(
      id: data['_id'],
      content: data['content'],
      author: data['author'],
      authorSlug: data['authorSlug'],
    );
  }
}

Future<void> saveQuoteToSharedPreferences(QuoteModal quote) async {
  final prefs = await SharedPreferences.getInstance();
  final quoteMap = {
    'id': quote.id,
    'content': quote.content,
    'author': quote.author,
    'authorSlug': quote.authorSlug,
  };
  await prefs.setStringList('saved_quote', quoteMap.values.toList());
}

class dateModel {
  DateTime datetime;
  String? dateTime;

  dateModel({
    required this.datetime,
  });
}
