import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/helper/Config.dart';
import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/repo/Repository.dart';

import 'MovieDetailScreen.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieState createState() => _MovieState();
}


class _MovieState extends State<MovieScreen> with SingleTickerProviderStateMixin{
  late Future<MovieData> futureMovie;
  late Future<Movie> futureCat;
  late TabController _tabController;
  int index = 0;

  @override
  void initState() {
    super.initState();

    futureMovie = Repository().fetchLatestMovie();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        index = _tabController.index;
      });
    });



  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(

          headerSliverBuilder: (BuildContext context,
              bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: Text('Movie App',
                    style: TextStyle(color: Colors.red[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 30),),
                  expandedHeight: 300,
                  shadowColor: Colors.white,
                  pinned: true,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                    background: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(top: 48, bottom: 48),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          child: FutureBuilder<MovieData>(
                            future: futureMovie,
                            builder: (context, snapshot){
                              if(snapshot.hasData){
                                var image;
                                if(snapshot.data!.backdropPath!=null){
                                  image = Config.imageUrl(snapshot.data!.backdropPath!);
                                } else {
                                  image = "https://image.freepik.com/free-vector/cinema-room-background_1017-8728.jpg";
                                }

                                var releaseDate;
                                if(snapshot.data!.releaseDate!=null){
                                  releaseDate = snapshot.data!.releaseDate!;
                                } else{
                                  releaseDate = "Just Now";
                                }

                                return SizedBox(
                                  height: 240,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Stack(
                                      fit: StackFit.loose,
                                      children: [
                                        CachedNetworkImage(imageUrl: image,
                                          imageBuilder: (context, imageProvider){
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover
                                              ),
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                          );
                                          },
                                          placeholder: (context, url)=> Image.network("https://image.freepik.com/free-vector/loading-icon_167801-436.jpg"),
                                          errorWidget: (context, url, error) => Center(
                                            child: Icon(Icons.broken_image_rounded,
                                              size: 80.0,),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Latest Movie',
                                              style: TextStyle(color: Colors.white),),
                                              Text(snapshot.data!.title!,
                                                style: TextStyle(color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),),
                                              Text(releaseDate,
                                              style: TextStyle(fontSize: 14,
                                              color: Colors.white70),)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                              else if(snapshot.hasError){
                                return Text("${snapshot.error} | ${snapshot.stackTrace.toString()}");
                              }

                              return Center(child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                bottom:
                  TabBar(tabs: [
                    Tab(text: "Now Playing",),
                    Tab(text: "Popular",),
                    Tab(text: "Coming Soon",)
                  ],
                    controller: _tabController,
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    unselectedLabelStyle: TextStyle(fontSize: 12),
                  ),
                ),
              )
            ];
          },

          body: Padding(
            padding: const EdgeInsets.only(top: 64),
            child: TabBarView(
              controller: _tabController,
              children: [
                movieType(Repository().fetchMoviePlaying()),
                movieType(Repository().fetchMoviePopular()),
                movieType(Repository().fetchMovieUpcoming())
              ],

            ),
          ),
          
        )
      ),
    );
  }

  Widget movieType(Future<Movie> futureMovie){
    return Builder(builder: (BuildContext context){
      return Container(
        margin: EdgeInsets.only(top: 52),
        child: FutureBuilder<Movie>(
          future: futureMovie,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return GridView.builder(shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16),
                gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              childAspectRatio: 0.75,),
                  itemCount: snapshot.data!.results!.length,
                  itemBuilder: (BuildContext context, int index ){
                String image;
                if(snapshot.data!.results![index].posterPath!=null){
                  image = Config.imageUrl(snapshot.data!.results![index].posterPath!);
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(movieData: snapshot.data!.results![index]),
                      // Pass the arguments as part of the RouteSettings. The
                      // DetailScreen reads the arguments from these settings.
                      settings: RouteSettings(
                      arguments: snapshot.data!.results![index],
                      ),
                      ));
                    },
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        CachedNetworkImage(imageUrl: image,
                        imageBuilder: (context, imageProvider){
                          return Container(
                            height: 320,
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
                        )
                      ],
                    ),
                  ),
                );
              },physics: ScrollPhysics(),
              );
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

}
