import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/models/news.dart';
import 'package:news/providers/news_provider.dart';
import 'package:provider/provider.dart';

class NewsView extends StatelessWidget {
  static String routeName = "/news-viewer";
  const NewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final newsId = routeArgs['newsId'];
    if (newsId == null) throw StateError('Missing news Id');

    final news = Provider.of<NewsProvider>(context, listen: false).getNewsById(
      newsId,
    );

    final formatedDate = DateFormat('MMM dd, yyyy HH:mm').format(
      news.publishedAt,
    );
    const _descStyle = TextStyle(color: Colors.white, fontSize: 10);

    return Scaffold(
      body: Stack(
        children: [
          // Column(
          //   children: [],
          // ),
          _imageBuilder(news.imageUrl),
          Positioned(
            top: 20,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          Positioned(
            top: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.source != null
                        ? news.source!.toUpperCase()
                        : 'UNKNOWN SOURCE',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: 9,
                      color: Colors.red,
                    ),
                  ),
                  Row(
                    children: [
                      Text(formatedDate, style: _descStyle),
                      const SizedBox(width: 5),
                      if (news.author != null) ...[
                        const Text('|', style: _descStyle),
                        const SizedBox(width: 5),
                        Text('By ${news.author}', style: _descStyle),
                      ]
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 300,
            child: ScrollConfiguration(
              behavior: _CustomScrollBehavior(),
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}',
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          // SingleChildScrollView(
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          //     clipBehavior: Clip.hardEdge,
          //     decoration: const BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(20),
          //         topRight: Radius.circular(20),
          //       ),
          //     ),
          //     child: Column(
          //       children: [
          //         Text(
          //           '${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}',
          //         )
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _imageBuilder(String imageUrl) {
    const double _size = double.infinity;
    const double _height = 350;
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      width: _size,
      height: _height,
      errorWidget: (context, url, error) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'assets/images/img_not_found.jpg',
            fit: BoxFit.cover,
            width: _size,
            height: _height,
          ),
        );
      },
      placeholder: (context, url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'assets/images/img_placeholder.jpg',
            fit: BoxFit.cover,
            width: _size,
            height: _height,
          ),
        );
      },
    );
  }

  Widget _newsContent(News news) {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: _CustomScrollBehavior(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [],
              //   ),
              // ),
              // Text(
              //   news.source != null
              //       ? news.source!.toUpperCase()
              //       : 'UNKNOWN SOURCE',
              //   style: const TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 9,
              //     color: Colors.red,
              //   ),
              // ),
              // Row(
              //   children: [
              //     Text(formatedDate, style: _descStyle),
              //     const SizedBox(width: 5),
              //     if (news.author != null) ...[
              //       const Text('|', style: _descStyle),
              //       const SizedBox(width: 5),
              //       Text('By ${news.author}', style: _descStyle),
              //     ]
              //   ],
              // ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Text(
                  '${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}${news.description}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
