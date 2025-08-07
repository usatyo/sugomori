import 'package:flutter/material.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:frontend/components/bottom_menu/bottom_menu.dart';
import 'package:frontend/components/goban_pagination/pagination.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models/youtube.dart';
import 'package:frontend/services/youtube_api_service.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class DetailPage extends StatefulWidget {
  final Video initialVideoInfo;
  const DetailPage({super.key, required this.initialVideoInfo});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final YoutubePlayerController _controller;
  final YoutubeApiService youtubeApiService = YoutubeApiService.instance;
  late Video videoInfo;

  @override
  void initState() {
    super.initState();
    setState(() {
      videoInfo = widget.initialVideoInfo;
    });
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.initialVideoInfo.id,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showFullscreenButton: false,
        strictRelatedVideos: true,
      ),
    );
    _controller.listen((data) {
      final String videoId = data.metaData.videoId;
      if (videoId.isNotEmpty && videoId != videoInfo.id) {
        (() async {
          Video video = await youtubeApiService.getVideoById(videoId: videoId);
          setState(() {
            videoInfo = video;
          });
        })();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double tabletPadding = context.isTablet() ? 100 : 0;
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomMenu(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: tabletPadding),
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
                          videoInfo.title,
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
                                  videoInfo.channel.thumbnailUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              videoInfo.channel.title,
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
                        Pagination(videoId: videoInfo.id),
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
