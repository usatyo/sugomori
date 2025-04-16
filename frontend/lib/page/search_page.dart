import 'package:flutter/material.dart';
import 'package:frontend/components/bottom_menu.dart';
import 'package:frontend/components/goban.dart';
import 'package:frontend/components/video_card.dart';
import 'package:frontend/models/youtube.dart';
import 'package:frontend/services/youtube_api_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  APIService apiService = APIService.instance;
  List<Video> videos = [];
  int counter = 0;
  void increment() {
    setState(() {
      apiService.fetchVideos(videoIds: ["-H4BlqZzAX8"]).then((value) {
        setState(() {
          videos = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Goban(),
          ),
          FilledButton(onPressed: increment, child: Text("fetch")),
          Expanded(
            child: Column(
              children:
                  videos.map((video) => VideoCard(videoInfo: video)).toList(),
            ),
          ),
          BottomMenu(),
        ],
      ),
    );
  }
}
