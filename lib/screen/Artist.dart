import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/helper/Config.dart';
import 'package:movie_app/model/Cast.dart';
import 'package:movie_app/repo/Repository.dart';

class Artist extends StatefulWidget {
  @override
  _ArtistState createState() => _ArtistState();
}

class _ArtistState extends State<Artist> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 16.0, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Cast", style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold,
                  color: Colors.red[800]
              ),),
              Flexible(child: castWidget(Repository().fetchCaster()))
            ],
          ),
        )
      ),
    );
  }

  Widget castWidget(Future<Cast> futureMovie){
    return Builder(builder: (BuildContext context){
      return Container(
        margin: EdgeInsets.only(top: 16),
        child: FutureBuilder<Cast>(
          future: futureMovie,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return GridView.builder(shrinkWrap: true,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    childAspectRatio: 0.75),
                itemCount: snapshot.data!.results!.length,
                itemBuilder: (BuildContext context, int index ){
                  String image;
                  if(snapshot.data!.results![index].profilePath!=null){
                    image = Config.imageUrl(snapshot.data!.results![index].profilePath!);
                  } else{
                    image="";
                  }
                  print('posterImage: $image');
                  return Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(14),
                        color: Colors.red[300]),
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
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Text(snapshot.data!.results![index].name!, style:
                                  TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 2
                                        ..color = Colors.grey),
                                  ),

                                  Text(snapshot.data!.results![index].name!, style:
                                  TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 16, color: Colors.white,),
                                  ),
                                ]
                              ),
                              Stack(
                                children: [
                                  Text(snapshot.data!.results![index].knownForDepartment!, style:
                                  TextStyle(fontSize: 13,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 1
                                        ..color = Colors.grey),
                                  ),

                                  Text(snapshot.data!.results![index].knownForDepartment!, style:
                                  TextStyle(fontSize: 13,
                                      color: Colors.white60),),

                                ],
                              )

                            ],
                          ),
                        )
                      ],
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
