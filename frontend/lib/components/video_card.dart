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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(videoInfo: widget.videoInfo),
            ),
          );
        },
        child: Row(
          children: [
            Image.network(widget.videoInfo.thumbnailUrl, width: 150),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      widget.videoInfo.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      widget.videoInfo.channelTitle,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
