import 'package:flutter/material.dart';
import 'package:movie_app/model/Movie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeScreen extends StatefulWidget {
  final String youtubeId;
  final MovieData data;
  YoutubeScreen({Key? key, required this.youtubeId, required this.data}) : super(key: key);

  @override
  _YoutubeScreenState createState() => _YoutubeScreenState(youtubeId: youtubeId, data: data);
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  final String youtubeId;
  final MovieData data;
  _YoutubeScreenState({required this.youtubeId, required this.data});
  late YoutubePlayerController _controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: youtubeId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,

      ),
    )..addListener(listener);
    _videoMetaData = YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,), builder: (context, player){
          return Scaffold(
            appBar: AppBar(
              title: Text(data.title!,),
              leading: InkWell(
                  child: Icon(Icons.chevron_left_rounded),
                onTap: (){
                    Navigator.pop(context);
                },),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                player,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        Text("Synopsis", style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(data.overview!),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
    });
  }
}
