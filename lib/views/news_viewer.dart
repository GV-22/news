import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/models/news.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/widgets/image_viewer.dart';
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
    const _descStyle = TextStyle(color: Colors.white, fontSize: 8);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.turned_in_not_outlined,
          color: news.saved ? Theme.of(context).colorScheme.primary : null,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            snap: true,
            floating: true,
            expandedHeight: 250.0,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.chevron_left,
                  color: Theme.of(context).colorScheme.secondary, size: 40),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(3),
                    color: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      news.title,
                      style: const TextStyle(fontSize: 10),
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    color: Colors.black,
                    padding: const EdgeInsets.all(3),
                    child: Row(
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
                  )
                ],
              ),
              background: ImageViewer(imageUrl: news.imageUrl, size: 350),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(20),
                    //   topRight: Radius.circular(20),
                    // ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${news.description}${news.description}${news.description}${news.description}${news.description}'
                        '${news.description}${news.description}${news.description}${news.description}${news.description}'
                        '${news.description}${news.description}${news.description}${news.description}${news.description}'
                        '${news.description}${news.description}${news.description}${news.description}${news.description}'
                        '${news.description}${news.description}${news.description}${news.description}${news.description}'
                        '${news.description}${news.description}${news.description}${news.description}${news.description}',
                        textAlign: TextAlign.justify,
                        style: const TextStyle(height: 1.7),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
