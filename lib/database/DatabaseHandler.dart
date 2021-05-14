import 'package:movie_app/model/Movie.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'movie.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE movies(adult BOOLEAN NOT NULL, backdrop_path TEXT, genre_ids TEXT, id INTEGER PRIMARY KEY, original_language TEXT, original_title TEXT, overview TEXT, popularity REAL, poster_path TEXT, release_date TEXT, title TEXT, video INTEGER, vote_average REAL,  vote_count INTEGER)",
        );
      },
      version: 2,
    );
  }

  Future<void> insertFavMovie(MovieData movieData) async {
    final Database db = await initializeDB();
    await db.insert('movies', movieData.toMap());
  }

  Future<void> deleteFavMovie(int id) async {
    final Database db = await initializeDB();
    await db.delete('movies',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<bool> isFavoriteMovie(int id) async {
    late int result = 0;
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('movies');
    final List<MovieData> listResult = queryResult.map((e) =>
        MovieData.fromMap(e)).toList();

    print("data ${listResult.toString()}");

    for (int i = 0; i < listResult.length; i++) {
      if (id == listResult[i].id) {
        result += 1;
      }
    }
    return result > 0;
  }

  Future<List<MovieData>> allMovieData() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('movies');
    return queryResult.map((e) => MovieData.fromMap(e)).toList();
  }
}