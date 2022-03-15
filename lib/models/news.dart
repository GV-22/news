enum NewsCategory {
  all,
  health,
  business,
  entertainment,
  sport,
  general,
  politics,
  tech
}

class News {
  final int newsId;
  final String? author;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String? source;
  final DateTime publishedAt;
  final NewsCategory category;
  bool saved;

  News({
    required this.newsId,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.source,
    required this.publishedAt,
    required this.category,
    this.saved = false,
  });

  void updateSaved(bool value) => saved = value;

  @override
  String toString() {
    return 'News(author: $author, title: $title, description: $description, url: $url, imageUrl: $imageUrl, source: $source, publishedAt: $publishedAt)';
  }
}
