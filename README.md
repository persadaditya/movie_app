# movie_app

Movie App from TMDB API

## Getting Started

### Movie App
This project is to display movie.

#### Home Screen
![now playing](images/home1.png?raw=true) | ![popular](images/home2.png?raw=true) | ![coming soon](images/home3.png?raw=true)

#### Search & detail
![search list](images/search-list.png?raw=true) | ![search detail](images/search-detail1.png?raw=true) | ![search detail](images/search-detail2.png?raw=true)

#### Favorite movie
![favorite list](images/fav-list.png?raw=true) | ![favorite detail](images/fav-detail1.png?raw=true) | ![favorite detail](images/fav-detail2.png?raw=true)

#### cast movie
![cast](images/cast.png?raw=true)

You can see latest, now play, popular, and coming soon also search movie
then you can see all caster too.

This application get data from [The Movie DB Api](https://www.themoviedb.org/settings/api)
you can start this project by replacing with your own apiKey at helper/config.dart file

### new added! 
persist data with sqflite-library (favorite screen)

This application also inspired by this design:
- [Movies app](https://dribbble.com/shots/6715286-Movies-app) from [MUSE](https://dribbble.com/siyumiao)
- [Movies app](https://dribbble.com/shots/7365479-Movies-App) from [Lay](https://dribbble.com/humble-designer)

Then I use some of useful widget like this:
- [NestedScrollView](https://api.flutter.dev/flutter/widgets/NestedScrollView-class.html)
- [Salomon Bottom App Bar](https://pub.dev/packages/salomon_bottom_bar)
- [TabBar and TabBarView](https://api.flutter.dev/flutter/material/TabBar-class.html)
- [Grid View](https://api.flutter.dev/flutter/widgets/GridView-class.html)
- [Persist Data - sqflite](https://flutter.dev/docs/cookbook/persistence/sqlite)


### Created from flutter
This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
