import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/models/news.dart';
import 'package:news/views/news_viewer.dart';
import 'package:news/widgets/image_viewer.dart';

class NewsItem extends StatelessWidget {
  final News _news;
  const NewsItem(this._news, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _height = 100;
    final formatedDate = DateFormat('MMM dd, yyyy HH:mm').format(
      _news.publishedAt,
    );
    const _textColor = Colors.white;
    const _descStyle = TextStyle(color: _textColor, fontSize: 10);
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        NewsView.routeName,
        arguments: {'newsId': _news.newsId},
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white, width: 0.1),
          ),
        ),
        height: _height,
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _news.source != null
                            ? _news.source!.toUpperCase()
                            : 'UNKNOWN SOURCE',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        _reduceTitle(_news.title),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: _textColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(formatedDate, style: _descStyle),
                      const SizedBox(width: 5),
                      if (_news.author != null) ...[
                        const Text('|', style: _descStyle),
                        const SizedBox(width: 5),
                        Text('By ${_news.author}', style: _descStyle),
                      ]
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              flex: 1,
              child: ImageViewer(imageUrl: _news.imageUrl, size: _height - 25),
            )
          ],
        ),
      ),
    );
  }

  String _reduceTitle(String value) {
    // get the first 50 characters of the description
    const _max = 50;
    return value.length < _max ? value : "${value.substring(0, _max)}…";
  }

 

  // String _reduceDescription(String description) {
  //   // get the first 50 characters of the description
  //   return description.length < 50
  //       ? description
  //       : "${description.substring(0, 50)}…";
  // }
}
