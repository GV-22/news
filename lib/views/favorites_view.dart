import 'package:flutter/material.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/widgets/news_item.dart';
import 'package:provider/provider.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final news =
        Provider.of<NewsProvider>(context, listen: false).getAllNews.take(7);
    // .where((element) => element.saved);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Saved",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        news.isEmpty
            ? Center(
                child: Column(
                  children: const [
                    Text(
                      "There is no saved article",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
            : Expanded(
                child: ListView.builder(
                  // restorationId: 'feed-list',
                  itemCount: news.length,
                  padding: const EdgeInsets.only(bottom: 15, top: 5),
                  itemBuilder: (BuildContext context, int index) {
                    return NewsItem(news.elementAt(index));
                  },
                ),
              ),
      ],
    );
  }
}
