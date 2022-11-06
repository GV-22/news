import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/models/news.dart';
import 'package:news/views/news_viewer.dart';
import 'package:news/widgets/image_viewer.dart';

class NewsItemGrid extends StatelessWidget {
  final News _news;
  const NewsItemGrid(this._news, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final formatedDate = DateFormat('MMM dd, yyyy HH:mm').format(
    //   _news.publishedAt,
    // );
    const _textColor = Colors.white;
    const _descStyle = TextStyle(color: _textColor, fontSize: 10);
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        NewsView.routeName,
        arguments: {'newsId': _news.newsId},
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[900],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                ImageViewer(imageUrl: _news.imageUrl, size: 110),
                const SizedBox(height: 10),
                Text(
                  _news.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: _textColor,
                  ),
                ),
              ],
            ),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _news.source != null
                      ? _news.source!.toUpperCase()
                      : 'UNKNOWN SOURCE',
                  style: const TextStyle(fontSize: 9, color: Colors.red),
                ),
                const SizedBox(height: 5),
                Text('By ${_news.author}', style: _descStyle)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageBuilder() {
    double _size = 110;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: CachedNetworkImage(
        imageUrl: _news.imageUrl,
        fit: BoxFit.cover,
        height: _size,
        width: double.infinity,
        errorWidget: (context, url, error) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/img_not_found.jpg',
              fit: BoxFit.cover,
              height: _size,
              width: double.infinity,
            ),
          );
        },
        placeholder: (context, url) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/img_placeholder.jpg',
              fit: BoxFit.cover,
              height: _size,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }

  // String _reduceDescription(String description) {
  //   // get the first 50 characters of the description
  //   return description.length < 50
  //       ? description
  //       : "${description.substring(0, 50)}…";
  // }
}
