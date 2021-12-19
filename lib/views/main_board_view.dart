import 'package:flutter/material.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/views/explore_view.dart';
import 'package:news/views/favorites_view.dart';
import 'package:news/views/feed_view.dart';
import 'package:provider/provider.dart';

class MainBoard extends StatefulWidget {
  const MainBoard({Key? key}) : super(key: key);

  @override
  _MainBoardState createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  int _currentTabIndex = 0;
  final List<Widget> _pages = const [
    FeedsView(),
    ExploreView(),
    FavoritesView(),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 10,
          left: 15,
          right: 15,
        ),
        child: _pages[_currentTabIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => _currentTabIndex = index),
        currentIndex: _currentTabIndex,
        selectedItemColor: Colors.red,
        selectedLabelStyle: const TextStyle(color: Colors.red, fontSize: 12),
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        items: [
          buildBottomBarItem("Feed", Icons.grid_view_outlined),
          buildBottomBarItem("Explore", Icons.explore_outlined),
          buildBottomBarItem("Saved", Icons.turned_in_not_outlined),
        ],
      ),
    );
  }

  BottomNavigationBarItem buildBottomBarItem(String label, IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: Colors.grey),
      activeIcon: Icon(icon),
      label: label,
    );
  }

  void initData() {
    Provider.of<NewsProvider>(context, listen: false).init();
  }
}
