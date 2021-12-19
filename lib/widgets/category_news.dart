import 'package:flutter/material.dart';
import 'package:news/widgets/news_item.dart';
import 'package:news/models/news.dart';
import 'package:news/providers/news_provider.dart';
import 'package:provider/provider.dart';

class CategoryViews extends StatefulWidget {
  const CategoryViews({Key? key}) : super(key: key);

  @override
  _CategoryViewsState createState() => _CategoryViewsState();
}

class _CategoryViewsState extends State<CategoryViews> {
  final List<NewsCategory> _categories = [
    NewsCategory.all,
    NewsCategory.business,
    NewsCategory.entertainment,
    NewsCategory.general,
    NewsCategory.health,
    NewsCategory.politics,
    NewsCategory.sport,
    NewsCategory.tech,
  ];

  NewsCategory _currentCategory = NewsCategory.all;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context, listen: false);
    List<News> _news = [];
    if (_currentCategory == NewsCategory.all) {
      _news = provider.getAllNews;
    } else {
      _news = provider.getAllNews
          .where((news) => news.category == _currentCategory)
          .toList();
    }

    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: ListView.builder(
              itemCount: _categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return _buildTabBtn(_categories[index]);
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _news.length,
              padding: const EdgeInsets.only(bottom: 15, top: 5),
              itemBuilder: (BuildContext context, int index) {
                return NewsItem(_news[index]);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabBtn(NewsCategory category) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        decoration: _currentCategory == category
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 3,
                  ),
                ),
              )
            : null,
        child: Text(
          _getCategoryLabel(category),
          style: TextStyle(
            color: _currentCategory == category
                ? Theme.of(context).colorScheme.secondary
                : Colors.white,
          ),
        ),
      ),
      onTap: () {
        setState(() => _currentCategory = category);
      },
    );
  }

  String _getCategoryLabel(NewsCategory category) {
    switch (category) {
      case NewsCategory.all:
        return 'All';
      case NewsCategory.business:
        return 'Business';
      case NewsCategory.entertainment:
        return 'Entertainment';
      case NewsCategory.general:
        return 'General';
      case NewsCategory.health:
        return 'Health';
      case NewsCategory.politics:
        return 'Politics';
      case NewsCategory.tech:
        return 'Tech';
      case NewsCategory.sport:
        return 'Sport';

      default:
        throw StateError('Unknown news category provide $category');
    }
  }
}
