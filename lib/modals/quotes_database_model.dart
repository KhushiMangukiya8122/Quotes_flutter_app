class QuotesDatabaseModel {
  int? id;
  String quotes;
  String author;

  QuotesDatabaseModel({
    required this.id,
    required this.quotes,
    required this.author,
  });

  factory QuotesDatabaseModel.formMap({required Map data}) {
    return QuotesDatabaseModel(
        id: data['id'],
        quotes: data['quote'],
        author: data['author'],
    );
  }
}