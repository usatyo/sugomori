import 'package:flutter/material.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:frontend/components/bottom_menu/bottom_menu.dart';
import 'package:frontend/components/goban_pagination/pagination.dart';
import 'package:frontend/models/joseki.dart';
import 'package:frontend/models/youtube.dart';
import 'package:frontend/services/joseki_api_service.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPage extends StatefulWidget {
  final Video videoInfo;
  const DetailPage({super.key, required this.videoInfo});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final YoutubePlayerController _controller;
  final JosekiApiService josekiApiService = JosekiApiService.instance;
  List<Joseki> josekiList = [];
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoInfo.id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        showLiveFullscreenButton: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
      builder: isFullScreen ? _fullScreenBuilder : _normalBuilder,
      onEnterFullScreen: () {
        setState(() {
          isFullScreen = true;
        });
      },
      onExitFullScreen: () {
        setState(() {
          isFullScreen = false;
        });
      },
    );
  }

  Widget _fullScreenBuilder(BuildContext context, Widget player) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(0),
              alignment: Alignment.center,
              child: player,
            ),
          ),
          BottomMenu(),
        ],
      ),
    );
  }

  Widget _normalBuilder(BuildContext context, Widget player) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(0),
            alignment: Alignment.center,
            child: player,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: ScrollShadow(
                color: Theme.of(context).cardColor,
                size: 20,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    children: [
                      Text(
                        widget.videoInfo.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Text(
                            widget.videoInfo.channelTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                      Divider(thickness: 0.5),
                      Pagination(videoId: widget.videoInfo.id),
                    ],
                  ),
                ),
              ),
            ),
          ),
          BottomMenu(),
        ],
      ),
    );
  }
}
