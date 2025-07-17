import 'package:flutter/material.dart';
import 'package:frontend/components/atoms/button.dart';
import 'package:frontend/components/bottom_menu/bottom_menu.dart';
import 'package:frontend/components/search/video_card.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/models/joseki.dart';
import 'package:frontend/models/youtube.dart';
import 'package:frontend/services/joseki_api_service.dart';
import 'package:frontend/services/youtube_api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  JosekiApiService josekiApiService = JosekiApiService.instance;
  String videoId = "";
  Video? videoInfo;
  Joseki joseki = Joseki([]);

  void onChangeUrl(String url) {
    setState(() {
      Uri uri = Uri.parse(url);
      if (uri.host != "www.youtube.com" && uri.host != "youtu.be") {
        videoId = "";
        videoInfo = null;
        return;
      }
      videoId = uri.queryParameters['v'] ?? "";
      YoutubeApiService youtubeApiService = YoutubeApiService.instance;
      youtubeApiService
          .fetchVideos(videoIds: [videoId])
          .then(
            (videos) => {
              if (videos.isNotEmpty)
                {videoInfo = videos[0]}
              else
                {videoInfo = null},
            },
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomMenu(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          children: [
            // Container(
            //   alignment: Alignment.center,
            //   child: Goban(joseki: joseki),
            // ),
            TextField(
              onChanged: onChangeUrl,
              decoration: InputDecoration(
                labelText: "Youtube URL",
                contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            VideoCard(videoInfo: videoInfo),
            Button(
              text: AppLocalizations.of(context)!.button_register,
              onPressed: () {
                josekiApiService.postJoseki(joseki, videoId);
              },
            ),
          ],
        ),
      ),
    );
  }
}
