
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/helper/Config.dart';
import 'package:movie_app/model/CreditVideo.dart';
import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/model/MovieDetail.dart';
import 'package:movie_app/model/MovieVideo.dart';
import 'package:movie_app/repo/Repository.dart';

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


  @override
  void initState() {
    super.initState();

    futureDetail = Repository().fetchDetailMovie(movieData.id!);
    futureVideo = Repository().fetchVideoMovie(movieData.id!);
    futureCredit = Repository().fetchCreditMovie(movieData.id!);

    backdrop = movieData.backdropPath == null ? " " : movieData.backdropPath!;
    poster = movieData.posterPath == null ? " " : movieData.posterPath!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(leading: Padding(
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
                onTap: ()=> Navigator.pop(context),
                ),
              ),
            ),
          ),
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(movieData.title!, textAlign: TextAlign.center, maxLines: 2,),
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


                  String runtime = "${snapshot.data!.runtime!} minutes" ;

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
                                  margin: EdgeInsets.only(right: 16),
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

                        Text("Overview", style:
                          TextStyle(fontWeight:
                          FontWeight.bold, fontSize: 20),),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(overview),
                        ),

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
                                  height: 130,
                                  child: Center(
                                    child: Text("no data trailer"),
                                  ),
                                ) :
                                SizedBox(
                                  height: 190,
                                  child: ListView.builder(itemCount: snapshot.data!.results!.length,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index){
                                        return Container(
                                          width: 240,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                fit: StackFit.loose,
                                                children: [
                                                  CachedNetworkImage(imageUrl: Config.thumbnailYoutube(snapshot.data!.results![index].key!),
                                                    imageBuilder: (context, imageProvider){
                                                      return Container(
                                                        width: 240,
                                                        height: 140,
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
                                                  )


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

                        Text("Cast", style:
                        TextStyle(fontWeight:
                        FontWeight.bold, fontSize: 20),),

                        Container(
                          height: 350,
                          constraints: BoxConstraints(maxHeight: 700),
                          child: FutureBuilder<CreditVideo>(
                            future: futureCredit,
                            builder: (context, snapshot){

                              if(snapshot.hasData){
                                return SizedBox(
                                  height: 200,
                                  child: GridView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 0.75,
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
                                                      ),

                                                      Text(name, style:
                                                      TextStyle(fontWeight: FontWeight.bold,
                                                        fontSize: 14, color: Colors.white,),
                                                      ),
                                                    ]
                                                ),
                                                Stack(
                                                  children: [
                                                    Text("as $character", style:
                                                    TextStyle(fontSize: 12,
                                                        foreground: Paint()
                                                          ..style = PaintingStyle.stroke
                                                          ..strokeWidth = 1
                                                          ..color = Colors.grey),
                                                    ),

                                                    Text("as $character", style:
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
                        ),

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
      )
    );
  }
}
