import 'package:flutter/material.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:frontend/components/bottom_menu.dart';
import 'package:frontend/components/goban.dart';
import 'package:frontend/components/video_card.dart';
import 'package:frontend/models/joseki.dart';
import 'package:frontend/models/youtube.dart';
import 'package:frontend/services/joseki_api_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Video> videos = [];
  int counter = 0;
  Joseki joseki = Joseki([]);
  JosekiApiService josekiApiService = JosekiApiService.instance;

  void fetchVideos() async {
    List<Video> newVideos = await josekiApiService.getVideos(joseki);
    setState(() {
      videos = newVideos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Goban(joseki: joseki),
          ),
          FilledButton(onPressed: fetchVideos, child: Text("fetch")),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: ScrollShadow(
                color: Theme.of(context).cardColor,
                size: 20,
                child: SingleChildScrollView(
                  child: Column(
                    children:
                        videos
                            .map((video) => VideoCard(videoInfo: video))
                            .toList(),
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
