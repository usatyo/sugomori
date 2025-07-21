import 'package:flutter/material.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:frontend/components/atoms/button.dart';
import 'package:frontend/components/bottom_menu/bottom_menu.dart';
import 'package:frontend/components/search/video_card.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/models/joseki.dart';
import 'package:frontend/models/youtube.dart';
import 'package:frontend/services/youtube_api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  YoutubeApiService youtubeApiService = YoutubeApiService.instance;
  String keyword = "";
  List<Video> resultVideos = [];
  Joseki joseki = Joseki([]);
  bool isLoading = false;

  void onChangeText(String text) {
    setState(() {
      keyword = text;
    });
  }

  void onButtonPressed() async {
    setState(() {
      isLoading = true;
    });
    List<Video> videos = await youtubeApiService.getVideosByWord(keyword);
    setState(() {
      resultVideos = videos;
      isLoading = false;
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
            TextField(
              onChanged: onChangeText,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.label_keyword,
                contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Button(
              text: AppLocalizations.of(context)!.button_search,
              onPressed: onButtonPressed,
            ),
            if (isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator())),
            if (!isLoading)
              Expanded(
                child: ScrollShadow(
                  color: Theme.of(context).cardColor,
                  size: 20,
                  child: SingleChildScrollView(
                    child: Column(
                      children:
                          resultVideos.isEmpty
                              ? [Text("")]
                              : resultVideos
                                  .map((video) => VideoCard(videoInfo: video))
                                  .toList(),
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
