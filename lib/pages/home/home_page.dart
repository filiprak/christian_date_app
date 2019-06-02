import 'package:christian_date_app/pages/home/profile_page.dart';
import 'package:christian_date_app/pages/home/search_page.dart';
import 'package:christian_date_app/state/actions/asyncActions.dart';
import 'package:christian_date_app/state/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'menu.dart';
import 'messages_page.dart';
import 'news_page.dart';


class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    store.dispatch(FetchCurrentUserDataAction().thunk(context));
  }

  static int _currentIndex = 0;

  final List<Widget> _children = [
    NewsPage(),
    MessagesPage(),
    SearchPage(),
    ProfilePage(),
  ];

  static final List<BottomNavigationBarItem> _bottomNavigation = [
    BottomNavigationBarItem(
      icon: Icon(Icons.view_list),
      title: Text('Tablica'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.mail),
      title: Text('Wiadomości'),
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.search),
        title: Text('Szukaj')
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text('Profil')
    )
  ];

  Text _currentTitle = _bottomNavigation[_currentIndex].title;


  @override
  Widget build(BuildContext context) {

    void onTabTapped(index) {
      setState(() {
        _currentIndex = index;
        _currentTitle = _bottomNavigation[index].title;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: _currentTitle,
      ),
      drawer: Drawer(
        child: Menu()
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        fixedColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        items: _bottomNavigation,
      ),
    );
  }
}
