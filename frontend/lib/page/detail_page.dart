import 'package:flutter/material.dart';
import 'package:frontend/components/bottom_menu.dart';
import 'package:frontend/models/youtube.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPage extends StatefulWidget {
  final Video videoInfo;
  const DetailPage({super.key, required this.videoInfo});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoInfo.id,
      flags: YoutubePlayerFlags(autoPlay: true, showLiveFullscreenButton: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                // onReady: () {
                //   _controller.addListener(listener);
                // },
              ),
            ),
          ),
          BottomMenu(),
        ],
      ),
    );
  }
}
