import 'package:flutter/material.dart';
import 'package:frontend/models/youtube.dart';
import 'package:frontend/pages/detail_page.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({super.key, required this.videoInfo});
  final Video? videoInfo;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.videoInfo == null) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              Container(
                width: 90 * 16 / 9,
                height: 90,
                color: Colors.grey[300],
              ),
              // Image.network(widget.videoInfo!.thumbnailUrl, width: 150),
              Expanded(
                child: Container(
                  height: 90,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        "video title",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        "channel title",
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
    } else {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(videoInfo: widget.videoInfo!),
              ),
            );
          },
          child: Row(
            children: [
              Image.network(widget.videoInfo!.thumbnailUrl, height: 90),
              Expanded(
                child: Container(
                  height: 90,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        widget.videoInfo!.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        widget.videoInfo!.channelTitle,
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
}
