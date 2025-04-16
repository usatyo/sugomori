import 'package:flutter/material.dart';
import 'package:frontend/models/youtube.dart';
import 'package:frontend/page/detail_page.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({super.key, required this.videoInfo});
  final Video videoInfo;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => DetailPage(videoInfo: widget.videoInfo),
          ));
        },
        child: Column(
          children: [
            Image.network(widget.videoInfo.thumbnailUrl),
            Text(widget.videoInfo.title),
            Text(widget.videoInfo.channelTitle),
          ],
        ),
      ),
    );
  }
}
