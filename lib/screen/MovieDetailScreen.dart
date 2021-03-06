
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/database/DatabaseHandler.dart';
import 'package:movie_app/helper/Config.dart';
import 'package:movie_app/helper/SizeConfig.dart';
import 'package:movie_app/model/CreditVideo.dart';
import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/model/MovieDetail.dart';
import 'package:movie_app/model/MovieVideo.dart';
import 'package:movie_app/repo/Repository.dart';
import 'package:movie_app/screen/YoutubeScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieData movieData;
  MovieDetailScreen({Key? key, required this.movieData}): super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState(movieData: movieData);
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final MovieData movieData;
  _MovieDetailScreenState({required this.movieData});
  late Future<MovieDetail> futureDetail;
  late Future<MovieVideo> futureVideo;
  late Future<CreditVideo> futureCredit;
  late String backdrop;
  late String poster;
  late ScrollController _scrollController;
  late DatabaseHandler handler;


  @override
  void initState() {
    super.initState();

    _scrollController = new ScrollController();
    _scrollController.addListener(() => setState(() {}));

    futureDetail = Repository().fetchDetailMovie(movieData.id!);
    futureVideo = Repository().fetchVideoMovie(movieData.id!);
    futureCredit = Repository().fetchCreditMovie(movieData.id!);

    backdrop = movieData.backdropPath == null ? " " : movieData.backdropPath!;
    poster = movieData.posterPath == null ? " " : movieData.posterPath!;

    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(()  async{
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(controller: _scrollController,
            slivers: [
              SliverAppBar(centerTitle: true,
                leading: Padding(
                padding: EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Material(
                    elevation: 10,
                    color: Colors.white70,
                    shadowColor: Colors.black45,
                    child: InkWell(child: SizedBox(
                        child: Icon(Icons.chevron_left_rounded,
                            size: 24, color: Colors.black45
                        )
                    )
                      ,splashColor: Colors.black45,
                      onTap: ()=> Navigator.pop(context, 'ok'),
                    ),
                  ),
                ),
              ),
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(movieData.title!,
                    textAlign: TextAlign.center,
                    maxLines: 1,),
                  background: Image.network(Config.imageUrl(backdrop),
                    fit: BoxFit.cover,),
                ),
              ),
              SliverFillRemaining(
                  hasScrollBody: false,
                  fillOverscroll: false,
                  child: FutureBuilder<MovieDetail>(
                    future: futureDetail,
                    builder: (context, snapshot){
                      if(snapshot.hasData){

                        List<String> genres = List<String>.empty(growable: true);
                        List<Genres> genreList = snapshot.data!.genres!;
                        String genre;
                        if(genreList.isNotEmpty||genreList.length>0){
                          for(int i=0;i<genreList.length;i++){
                            genres.add(genreList[i].name!);
                          }
                          genre = genres.join(", ");
                        } else {
                          genre = "no genre data found";
                        }


                        String runtime = snapshot.data!.runtime == null ? "No data":
                          "${snapshot.data!.runtime!} minutes" ;

                        String year = snapshot.data!.releaseDate!.split("-")[0];

                        String countries =
                        snapshot.data!.productionCountries==null||snapshot.data!.productionCountries!.length==0 ?
                        "no country" : snapshot.data!.productionCountries![0].name!;

                        String overview =
                        snapshot.data!.overview!.isEmpty ? "No synopsis found":
                        snapshot.data!.overview!;

                        String language = snapshot.data!.spokenLanguages==null
                            ||snapshot.data!.spokenLanguages!.length==0 ? "No data" : snapshot.data!.spokenLanguages![0].name! ;
                        String popularity = snapshot.data!.popularity!.toString();
                        String voteCount = snapshot.data!.voteCount!.toString();

                        return Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(imageUrl: Config.imageUrl(poster),
                                    imageBuilder: (context, imageProvider){
                                      return Container(
                                        width: 110,
                                        height: 160,
                                        margin: EdgeInsets.only(right: 16,),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      );
                                    },
                                    placeholder: (context, url)=> Container(
                                        width: 110,
                                        height: 160,
                                        margin: EdgeInsets.only(right: 16),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.black
                                        ),
                                        child: Image.network("https://image.freepik.com/free-vector/loading-icon_167801-436.jpg")),
                                    errorWidget: (context, url, error) => Container(
                                      width: 110,
                                      height: 160,
                                      margin: EdgeInsets.only(right: 16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red,
                                      ),
                                      child: Center(
                                        child: Icon(Icons.broken_image_rounded,
                                          size: 60.0, color: Colors.white38,),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 150,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(movieData.originalTitle!, maxLines: 2,
                                            style: TextStyle(fontWeight: FontWeight.bold,
                                              fontSize: 24, ),),

                                          Row(
                                            children: [
                                              RatingBarIndicator(
                                                rating: movieData.voteAverage!/2,
                                                itemBuilder: (context, index) => Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 20.0,
                                                direction: Axis.horizontal,
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(left: 8.0),
                                                child: Text(movieData.voteAverage!.toString()),
                                              ),

                                            ],
                                          ),

                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 8.0),
                                              child: Text(genre, style:
                                              TextStyle(fontStyle: FontStyle.italic,
                                                  color: Colors.black45),),
                                            ),
                                          ),

                                          Expanded(
                                            child: Text(runtime, style:
                                            TextStyle(color: Colors.black45),),
                                            flex: 2,
                                          ),

                                          Expanded(
                                            child: Text("$year - $countries", style:
                                            TextStyle(color: Colors.black45),),
                                            flex: 0,
                                          ),

                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 24.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Language", style:
                                          TextStyle(color: Colors.black38),),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4.0),
                                            child: Text(language, style:
                                            TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                          )
                                        ],
                                      ),
                                      flex: 2,
                                    ),

                                    Expanded(
                                      child: Container(height: 42,
                                          child: VerticalDivider(color: Colors.grey,)),

                                    ),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Popularity", style:
                                          TextStyle(color: Colors.black38),),
                                          Padding(
                                            padding:EdgeInsets.only(top :4.0),
                                            child: Text(popularity, style:
                                            TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                          )
                                        ],
                                      ),
                                      flex: 2,
                                    ),

                                    Expanded(
                                      child: Container(height: 42,
                                          child: VerticalDivider(color: Colors.grey,)),
                                    ),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Vote Count", style:
                                          TextStyle(color: Colors.black38),),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4.0),
                                            child: Text(voteCount, style:
                                            TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                          )
                                        ],
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                ),
                              ),

                              buildOverview(overview),

                              buildTrailer(),

                              buildCast(),

                            ],
                          ),
                        );
                      } else if(snapshot.hasError) {
                        return Center(child: Text("Error ${snapshot.error.toString()}"),);
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  )

              )

            ],
          ),

          buildFab(),

        ],
      )
    );
  }

  Widget buildOverview(String overview){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Overview", style:
        TextStyle(fontWeight:
        FontWeight.bold, fontSize: 20),),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(overview),
        ),
      ],
    );
  }

  Widget buildTrailer(){
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 24, bottom: 16),
          child: Text("Trailer", style:
          TextStyle(fontWeight:
          FontWeight.bold, fontSize: 20),),),

        Padding(padding: EdgeInsets.only(bottom: 24),
          child: Container(
            child: FutureBuilder<MovieVideo>(
              future: futureVideo,
              builder: (context, snapshot){
                List<MovieVideoData> detail = List<MovieVideoData>.empty(growable: true);

                if(snapshot.hasData){

                  return snapshot.data!.results!.isEmpty || snapshot.data!.results!.length == 0 ?
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],

                    ),
                    child: Center(
                      child: Text("no data trailer"),
                    ),
                  ) :

                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 30,
                    child: ListView.builder(itemCount: snapshot.data!.results!.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index){

                          String youtubeId = snapshot.data!.results![index].id!;
                          String key = snapshot.data!.results![index].key!;
                          print("youtubeId= $youtubeId | key= $key");
                          return InkResponse(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) => YoutubeScreen(
                                      youtubeId: snapshot.data!.results![index].key!,
                                      data: movieData,),
                                  )
                              );
                            },
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    fit: StackFit.loose,
                                    children: [
                                      CachedNetworkImage(imageUrl: Config.thumbnailYoutube(snapshot.data!.results![index].key!),
                                        imageBuilder: (context, imageProvider){
                                          return Container(
                                            width: SizeConfig.safeBlockHorizontal *60,
                                            height: SizeConfig.safeBlockVertical *20,
                                            margin: EdgeInsets.only(right: 16),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,),
                                              borderRadius: BorderRadius.all(Radius.circular(10),
                                              ),
                                            ),
                                          );
                                        },
                                        placeholder: (context, url)=> Container(
                                            width: 240,
                                            height: 140,
                                            child: Image.network("https://image.freepik.com/free-vector/loading-icon_167801-436.jpg")),
                                        errorWidget: (context, url, error) => Container(
                                          width: 240,
                                          height: 140,
                                          child: Center(
                                            child: Icon(Icons.broken_image_rounded,
                                              size: 80.0,),
                                          ),
                                        ),
                                      ),

                                      Container(
                                        height: 140,
                                        width: 240,
                                        child: Center(
                                          child: Icon(Icons.play_circle_fill, size: 48,
                                            color: Colors.white,),
                                        ),
                                      ),

                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal:8.0,vertical: 4),
                                    child: Text(snapshot.data!.results![index].name!, style:
                                    TextStyle(fontWeight: FontWeight.bold),maxLines: 1,),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal:8.0),
                                    child: Text(snapshot.data!.results![index].type!, style:
                                    TextStyle(color: Colors.black38),),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  );

                } else if(snapshot.hasError){
                  return Container(height: 200,
                      child: Center(child:
                      Text(snapshot.error.toString())));
                }

                return SizedBox(
                  height: 190,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),),
      ],
    );
  }

  Widget buildCast(){

    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text("Cast", style:
        TextStyle(fontWeight:
        FontWeight.bold, fontSize: 20),),

        FutureBuilder<CreditVideo>(
          future: futureCredit,
          builder: (context, snapshot){

            if(snapshot.hasData){
              if(snapshot.data!.cast!.length>0){
                return SizedBox(
                  height: SizeConfig.safeBlockHorizontal * 80,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.25,
                    ), itemBuilder: (BuildContext context, int index){

                    String image = snapshot.data!.cast![index].profilePath == null ? " " : Config.imageUrl(snapshot.data!.cast![index].profilePath!);
                    String name = snapshot.data!.cast![index].name == null ? "No data" : snapshot.data!.cast![index].name!;
                    String character = snapshot.data!.cast![index].character == null ? "No data" : snapshot.data!.cast![index].character!;

                    return Container(
                      margin: EdgeInsets.all(5),
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          CachedNetworkImage(imageUrl: image,
                            imageBuilder: (context, imageProvider){
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.red[200],
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            },
                            placeholder: (context, url) => Image.network("https://venngage-wordpress.s3.amazonaws.com/uploads/2018/02/blog_header-1.png"),
                            errorWidget: (context, url, error) => Container(
                              decoration: BoxDecoration(
                                color: Colors.red[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Icon(Icons.person_rounded, color: Colors.white38,
                                  size: 50.0,),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                    children: [
                                      Text(name, style:
                                      TextStyle(fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 2
                                            ..color = Colors.grey),
                                        maxLines: 2,
                                      ),

                                      Text(name, maxLines: 2, style:
                                      TextStyle(fontWeight: FontWeight.bold,
                                        fontSize: 14, color: Colors.white,),
                                      ),
                                    ]
                                ),
                                Stack(
                                  children: [
                                    Text("as $character", maxLines: 2,style:
                                    TextStyle(fontSize: 12,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 1
                                          ..color = Colors.grey),
                                    ),

                                    Text("as $character", maxLines: 2,style:
                                    TextStyle(fontSize: 12,
                                        color: Colors.white60),),

                                  ],
                                )

                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                    itemCount: snapshot.data!.cast!.length,
                  ),
                );
              } else {
                return Container(
                  height: 140,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300]
                  ),
                  child: Center(
                    child: Text("No data cast"),
                  ),
                );
              }
            } else if(snapshot.hasError){
              return Container(
                height: 200,
                child: Center(
                  child: Text(snapshot.error.toString()),
                ),
              );
            }
            return Container(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ],
    );
  }

  _launchURL() async {
    if (Platform.isIOS) {
      if (await canLaunch(
          'youtube://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw')) {
        await launch(
            'youtube://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw',
            forceSafariVC: false);
      } else {
        if (await canLaunch(
            'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw')) {
          await launch(
              'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw');
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
        }
      }
    } else {
      const url = 'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  Widget buildFab(){
    //starting fab position
    final double defaultTopMargin = 220.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 96.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }
    
    
    return FutureBuilder(
      future: handler.isFavoriteMovie(movieData.id!),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        if (snapshot.hasData){
          if(snapshot.data!){
            return new Positioned(
                top: top,
                right: 16.0,
                child: new Transform(
                  transform: new Matrix4.identity()..scale(scale),
                  alignment: Alignment.center,
                  child: new FloatingActionButton(
                    onPressed: () => clickFavorite(true),
                    child: new Icon(Icons.favorite_rounded),
                  ),
                )
            );
          } else {
            return new Positioned(
                top: top,
                right: 16.0,
                child: new Transform(
                  transform: new Matrix4.identity()..scale(scale),
                  alignment: Alignment.center,
                  child: new FloatingActionButton(
                    onPressed: () => clickFavorite(false),
                    child: new Icon(Icons.favorite_border_outlined),
                  ),
                )
            );
          }
        }
        return new Positioned(
            top: top,
            right: 16.0,
            child: new Transform(
              transform: new Matrix4.identity()..scale(scale),
              alignment: Alignment.center,
              child: new FloatingActionButton(onPressed: () => {},
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: CircularProgressIndicator(backgroundColor: Colors.white,),
                ),
              ),
            )
        );
      },
    );
  }

  void clickFavorite(bool isFav){
    if(isFav){
      handler.deleteFavMovie(movieData.id!);
      var snackBar = SnackBar(content: Text("remove from favorite"),
        duration: Duration(seconds: 1),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      handler.insertFavMovie(movieData);
      var snackBar = SnackBar(content: Text("added from favorite"),
        duration: Duration(seconds: 1),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {
    });
  }
}
