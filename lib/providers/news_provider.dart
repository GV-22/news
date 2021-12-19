import 'package:flutter/material.dart';
import 'package:news/data/business.dart';
import 'package:news/data/entertainment.dart';
import 'package:news/data/general.dart';
import 'package:news/data/health.dart';
import 'package:news/data/politics.dart';
import 'package:news/data/sports.dart';
import 'package:news/data/tech.dart';
import 'package:news/models/news.dart';
import 'package:news/models/types.dart';

class NewsProvider extends ChangeNotifier {
  List<News> _news = [];

  void setNews(List<News> news) {
    _news = news;
    // notifyListeners();
  }

  List<News> get getAllNews => [..._news];
  
  News getNewsById(int id) {
    try {
      return _news.singleWhere((news) => news.newsId == id);
    } catch (e) {
      throw StateError('Unknown news with id $id');
    }
  }

  void init() {
    // init news
    final start = DateTime.now();
    int newsId = 1;
    List<News> allNews = [];
    newsId = initNews(businessNews, allNews, newsId, NewsCategory.business);
    newsId = initNews(
        entertainmentNews, allNews, newsId, NewsCategory.entertainment);
    newsId = initNews(generalNews, allNews, newsId, NewsCategory.general);
    newsId = initNews(healthNews, allNews, newsId, NewsCategory.health);
    newsId = initNews(politicNews, allNews, newsId, NewsCategory.politics);
    newsId = initNews(sportNews, allNews, newsId, NewsCategory.sport);
    newsId = initNews(techNews, allNews, newsId, NewsCategory.tech);

    print("Duration ${(DateTime.now().difference(start)).inMilliseconds}");
    allNews.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));

    setNews(allNews);
    // print("newsId $newsId, _news.len ${_news.length}");
  }

  List<News> filterNews(Filter filter) {
    // print("filter $filter");
    switch (filter) {
      case Filter.mostRecent:
        return _mostRecent();
      case Filter.lastMonth:
        return _lastMonth();
      case Filter.oldNews:
        return _oldNews();

      default:
        throw "Unknown filter $filter";
    }
  }

  List<News> _mostRecent() {
    return _news.take(25).toList();
  }

  List<News> _lastMonth() {
    final currentMonth = DateTime.now().month;
    return _news
        .where((news) => currentMonth - news.publishedAt.month == 1)
        .toList();
  }

  List<News> _oldNews() {
    final currentMonth = DateTime.now().month;
    return _news
        .where((news) => currentMonth - news.publishedAt.month > 1)
        .toList();
  }

  List<News> searchByToken(String token) {
    return _news
        .where((news) => news.title.toLowerCase().contains(token.toLowerCase()))
        .toList();
  }

  int initNews(
    List<Map<String, String?>> data,
    List<News> news,
    int nextNewsId,
    NewsCategory category,
  ) {
    for (var item in data) {
      final String? title = item['title'];
      final String? description = item['description'];
      final String? url = item['url'];
      final String? imageUrl = item['image'];

      if (title == null ||
          description == null ||
          url == null ||
          imageUrl == null) continue;

      news.add(
        News(
          newsId: nextNewsId,
          author: item['author'],
          title: title,
          description: description,
          url: url,
          imageUrl: imageUrl,
          source: item['source'],
          publishedAt: DateTime.parse(item['published_at'] as String),
          category: category,
        ),
      );

      nextNewsId += 1;
    }

    return nextNewsId;
  }
}
