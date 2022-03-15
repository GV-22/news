import 'package:flutter/material.dart';
import 'package:news/widgets/category_news.dart';
import 'package:news/widgets/news_item_grid.dart';
import 'package:news/providers/news_provider.dart';

import 'package:news/views/search_view.dart';
import 'package:provider/provider.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  Widget build(BuildContext context) {
    final news =
        Provider.of<NewsProvider>(context, listen: false).getAllNews.take(15);
    const double _size = 230;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Explore",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          readOnly: true,
          onTap: () => Navigator.of(context).pushNamed(
            SearchView.routeName,
          ),
          decoration: InputDecoration(
            hintText: 'Search…',
            contentPadding: EdgeInsets.zero,
            hintStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w100,
              fontSize: 13,
            ),
            prefixIcon: const Icon(
              Icons.search_outlined,
              color: Colors.white,
              size: 20,
            ),
            // enabledBorder: const OutlineInputBorder(
            //   // borderSide: BorderSide(width: 0.7),
            //   borderRadius: BorderRadius.all(Radius.circular(15)),
            // ),
            border: const OutlineInputBorder(
              // borderSide: BorderSide(width: 0.7),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            fillColor: Colors.grey[900],
            filled: true,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          "Editor's Choice",
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: _size,
          child: GridView.builder(
            itemCount: news.length,
            shrinkWrap: false,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: _size - 50, // width
              maxCrossAxisExtent: _size, // height
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext bCtx, i) =>
                NewsItemGrid(news.elementAt(i)),
          ),
        ),
        const SizedBox(height: 30),
        const CategoryViews()
      ],
    );
  }
}
