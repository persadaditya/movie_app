import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/helper/Config.dart';
import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/repo/Repository.dart';

import 'MovieDetailScreen.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController _searchController;
  late String search;
  late PagingController<int, MovieData> _pagingController;

  @override
  void initState() {
    super.initState();

    search="";
    _searchController = TextEditingController();
    _searchController.addListener(() {
      search = _searchController.text.toString();
    });

    _pagingController = PagingController(firstPageKey: 1);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(search, pageKey);
    });

  }

  Future<void> _fetchPage(String search, int pageKey) async {
    try {
      final newUpcoming = await Repository().fetchSearchMovie(search, pageKey);
      final isLastPage = newUpcoming.results!.length < 20;
      if(isLastPage){
        _pagingController.appendLastPage(newUpcoming.results!);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newUpcoming.results!, nextPageKey);
      }
    } catch (error){
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 16.0, left: 16, right: 16,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Search", style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold,
                color: Colors.pink[800]
              ),),
              Padding(
                padding:EdgeInsets.symmetric(vertical: 12),
                child: TextField(controller: _searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(36)),
                  hintText: "Search your movie here"
                ),
                  onSubmitted: (s){
                  print("textField: $s");
                  setState(() {
                    search = s;
                    _pagingController.refresh();
                  });
                  },
                ),
              ),
              Expanded(child: moviePaginated(_pagingController))
              // Flexible(child: movieType(Repository().fetchSearchMovie(search)))
            ],
          ),
        )
      ),
    );
  }

  Widget moviePaginated(PagingController<int, MovieData> pagingController){
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(left:8.0, right: 8.0),
          sliver: PagedSliverGrid<int, MovieData>(
            pagingController: pagingController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            builderDelegate: PagedChildBuilderDelegate<MovieData>(
              firstPageErrorIndicatorBuilder: (context) =>
                Center(child: Text("Please search your movie first")),
                noItemsFoundIndicatorBuilder: (context) =>
                Center(child: Text("No items found", style:
                  TextStyle(fontSize: 22),),),
                itemBuilder: (context, snapshot, index){

                  String image = snapshot.posterPath == null ? "" :
                  Config.imageUrl(snapshot.posterPath!);                    return Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(14),
                        color: Colors.red[300]),
                    child: InkResponse(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailScreen(movieData: snapshot),
                              // Pass the arguments as part of the RouteSettings. The
                              // DetailScreen reads the arguments from these settings.
                              settings: RouteSettings(
                                arguments: snapshot,
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
                            placeholder: (context, url) => Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Center(child: CircularProgressIndicator())),
                            errorWidget: (context, url, error) => Center(
                              child: Icon(Icons.broken_image_rounded,
                                size: 80.0,),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),

        ),

      ],
    );
  }


  Widget movieType(Future<Movie> futureMovie){
    return Builder(builder: (BuildContext context){
      return Container(
        margin: EdgeInsets.only(top: 14),
        child: FutureBuilder<Movie>(
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
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(child: Center(child: Icon(Icons.broken_image_rounded, size: 60,))),
                                  Text(snapshot.data!.results![index].title!,
                                    style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text("Language: ${snapshot.data!.results![index].originalLanguage!}"),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },physics: ScrollPhysics(),
              );
            } else if (snapshot.hasError) {
              print("${snapshot.stackTrace.toString()}");
              return Center(child: Text("No data provided"));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      );
    }
    );
  }
}
