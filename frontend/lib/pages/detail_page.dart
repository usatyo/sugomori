import 'package:flutter/material.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:frontend/components/atoms/button.dart';
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
  final GlobalKey _key = GlobalKey<State<Pagination>>();

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoInfo.id,
      flags: YoutubePlayerFlags(autoPlay: true, showLiveFullscreenButton: true),
    );
  }

  void refreshJoseki() async {
    List<Joseki> newJosekiList = await josekiApiService.getJoseki(
      widget.videoInfo.id,
    );
    setState(() {
      josekiList = [...newJosekiList];
    });
    _key.currentState?.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(0),
            alignment: Alignment.center,
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
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
                      // Button(text: "refresh", onPressed: refreshJoseki),
                      Pagination(),
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
