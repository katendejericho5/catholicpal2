class NewsArticle {
  final String _title;
  final String _description;
  final String _link;
  final String _author;
  final String _pubDate;

  NewsArticle({
    required String title,
    required String description,
    required String link,
    required String author,
    required String pubDate,
  })  : _link = link,
        _description = description,
        _title = title,
        _author = author,
        _pubDate = pubDate;

  get title => _title;
  get description => _description;
  get link => _link;
  get author => _author;
  get pubDate => _pubDate;
}
