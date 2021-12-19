import 'package:flutter/material.dart';
import 'package:news/widgets/news_item.dart';
import 'package:news/models/news.dart';
import 'package:news/providers/news_provider.dart';

import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  static String routeName = "/search-view";
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<News> news = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        title: _buildSearchForm(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: news.length,
          itemBuilder: (BuildContext context, int index) {
            return NewsItem(news[index]);
          },
        ),
      ),
    );

  }

  Widget _buildSearchForm() {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        hintText: 'Search…',
        hintStyle: TextStyle(color: Colors.white),
        suffixIcon: Icon(Icons.search_outlined),
      ),
      autofocus: true,
      cursorColor: Colors.white,
      onChanged: (token) {
        if (token.trim().isEmpty) return;
        setState(() {
          news = Provider.of<NewsProvider>(context, listen: false)
              .searchByToken(token);
        });
      },
    );
  }
}
