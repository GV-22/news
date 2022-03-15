import 'package:flutter/material.dart';
import 'package:news/widgets/news_item.dart';
import 'package:news/models/types.dart';
import 'package:news/providers/news_provider.dart';

import 'package:news/views/search_view.dart';
import 'package:provider/provider.dart';

class FeedsView extends StatefulWidget {
  const FeedsView({Key? key}) : super(key: key);

  @override
  State<FeedsView> createState() => _FeedsViewState();
}

class _FeedsViewState extends State<FeedsView> {
  Filter filter = Filter.mostRecent;

  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final news =
        Provider.of<NewsProvider>(context, listen: false).filterNews(filter);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "My Feed",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed(
                SearchView.routeName,
              ),
              icon: const Icon(
                Icons.search_outlined,
                color: Colors.white,
                size: 30,
              ),
            )
            // Icon(Icons.search_outlined)
          ],
        ),
        const SizedBox(height: 10),
        DropdownButtonHideUnderline(
          child: DropdownButton<Filter>(
            items: _buildDropDownItems().toList(),
            icon: const Icon(
              Icons.expand_more_outlined,
              color: Colors.white,
              size: 20,
            ),
            value: filter,
            onChanged: (newFilter) {
              setState(() => filter = newFilter ?? filter);
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            // restorationId: 'feed-list',
            itemCount: news.length,
            padding: const EdgeInsets.only(bottom: 15, top: 5),
            itemBuilder: (BuildContext context, int index) {
              return NewsItem(news.elementAt(index));
            },
          ),
        )
      ],
    );
  }

  final List<Filter> _filters = [
    Filter.mostRecent,
    Filter.lastMonth,
    Filter.oldNews,
  ];
  Iterable<DropdownMenuItem<Filter>> _buildDropDownItems() {
    return _filters.map(
      (f) => DropdownMenuItem(
        child: Text(
          getFilterLabel(f),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        value: f,
      ),
    );
  }

  String getFilterLabel(Filter filter) {
    switch (filter) {
      case Filter.mostRecent:
        return 'Most recent';
      case Filter.lastMonth:
        return 'Last month';
      case Filter.oldNews:
        return 'Old news';

      default:
        throw "Unknown filter $filter";
    }
  }
}
