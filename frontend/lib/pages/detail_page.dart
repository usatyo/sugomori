import 'package:flutter/material.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:frontend/components/bottom_menu/bottom_menu.dart';
import 'package:frontend/components/goban_pagination/pagination.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models/joseki.dart';
import 'package:frontend/models/youtube.dart';
import 'package:frontend/services/joseki_api_service.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

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
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoInfo.id,
      autoPlay: true,
      params: const YoutubePlayerParams(showFullscreenButton: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomMenu(),
      body: Padding(
        padding:
            context.isTablet()
                ? EdgeInsets.symmetric(horizontal: 100)
                : EdgeInsets.all(0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(0),
              alignment: Alignment.center,
              child: YoutubePlayer(
                controller: _controller,
                aspectRatio: 16 / 9,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  widget.videoInfo.channel.thumbnailUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              widget.videoInfo.channel.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Divider(thickness: 0.5),
                        Pagination(videoId: widget.videoInfo.id),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
