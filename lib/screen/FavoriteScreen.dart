import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/database/DatabaseHandler.dart';
import 'package:movie_app/helper/Config.dart';
import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/screen/MovieDetailScreen.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late DatabaseHandler handler;
  late Future<List<MovieData>> futureMovieFav;

  @override
  void initState() {

    super.initState();

    handler = DatabaseHandler();
    futureMovieFav = handler.allMovieData();


    handler.initializeDB().whenComplete(() async {
      futureMovieFav = handler.allMovieData();
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Favorite", style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold,
                  color: Colors.red[800]
              ),),
              Flexible(child: favoriteWidget(futureMovieFav))
            ],
          ),
        )
      ),
    );
  }


  Widget favoriteWidget(Future<List<MovieData>> futureMovie){
    return Builder(builder: (BuildContext context){
      return Container(
        margin: EdgeInsets.only(top: 16),
        child: FutureBuilder<List<MovieData>>(
          future: futureMovie,
          builder: (BuildContext context,AsyncSnapshot<List<MovieData>> snapshot){
            if(snapshot.hasData){
              if(snapshot.data!.isEmpty){
                return Expanded(child: Center(
                  child: Text("No Data Favorite added"),
                ));
              } else {
                return GridView.builder(shrinkWrap: true,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                      childAspectRatio: 0.75),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index ){
                    String image;
                    if(snapshot.data![index].posterPath!=null){
                      image = Config.imageUrl(snapshot.data![index].posterPath!);
                    } else{
                      image="";
                    }
                    print('posterImage: $image');
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14),
                          color: Colors.red[300]),
                      child: InkResponse(
                        onTap: (){
                          tapDetail(context, snapshot.data![index]);
                        },
                        child: CachedNetworkImage(imageUrl: image,
                          imageBuilder: (context, imageProvider){
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.red[200],
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                            );
                          },
                          placeholder: (context, url) => Image.network("https://venngage-wordpress.s3.amazonaws.com/uploads/2018/02/blog_header-1.png"),
                          errorWidget: (context, url, error) => Center(
                            child: Icon(Icons.broken_image_rounded,
                              size: 80.0,),
                          ),
                        ),
                      ),
                    );
                  },physics: ScrollPhysics(),
                );
              }
            } else if (snapshot.hasError) {
              return Text("${snapshot.error} | ${snapshot.stackTrace.toString()}");
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      );
    }
    );
  }

  void tapDetail(BuildContext context, MovieData movieData) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailScreen(movieData: movieData),
          // Pass the arguments as part of the RouteSettings. The
          // DetailScreen reads the arguments from these settings.
          settings: RouteSettings(
            arguments: movieData,
          ),
        ));

    if(result=="ok"){

      futureMovieFav = handler.allMovieData();
      setState(() {
      });
    }
  }
}
