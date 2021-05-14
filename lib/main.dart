import 'package:flutter/material.dart';
import 'package:movie_app/screen/Artist.dart';
import 'package:movie_app/screen/FavoriteScreen.dart';
import 'package:movie_app/screen/MovieScreen.dart';
import 'package:movie_app/screen/Search.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;
  List<Widget> listWidget = List<Widget>.empty(growable: true);


  @override
  void initState() {
    super.initState();

    _currentIndex=0;

    listWidget.add(MovieScreen());
    listWidget.add(Search());
    listWidget.add(FavoriteScreen());
    listWidget.add(Artist());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listWidget[_currentIndex],
      bottomNavigationBar:
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration( color: Colors.white, boxShadow: [
          BoxShadow(offset: Offset.fromDirection(3), color: Colors.black87,
          blurRadius: 24)
        ],
          borderRadius: BorderRadius.vertical(top: Radius.circular(40))
        ),
        child: SalomonBottomBar(
          margin: EdgeInsets.symmetric(horizontal: 48, vertical: 14),
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.movie, ),
              title: Text("Movie"),
              selectedColor: Colors.red,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Icon(Icons.search_rounded, ),
              title: Text("Search"),
              selectedColor: Colors.red,
            ),

            ///favorite
            SalomonBottomBarItem(
                icon: Icon(Icons.favorite_rounded),
                title: Text("Favorite"),
                selectedColor: Colors.red,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(Icons.person_pin_outlined, ),
              title: Text("Cast"),
              selectedColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}




