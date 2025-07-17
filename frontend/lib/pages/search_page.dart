import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_scroll_shadow/flutter_scroll_shadow.dart';
import 'package:frontend/components/atoms/button.dart';
import 'package:frontend/components/bottom_menu/bottom_menu.dart';
import 'package:frontend/components/goban/goban.dart';
import 'package:frontend/components/search/video_card.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/models/joseki.dart';
import 'package:frontend/models/youtube.dart';
import 'package:frontend/providers/provider.dart';
import 'package:frontend/services/joseki_api_service.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  List<Video> videos = [];
  int counter = 0;
  Joseki joseki = Joseki([]);
  JosekiApiService josekiApiService = JosekiApiService.instance;
  bool isLoading = false;
  String errorMessage = "";

  void fetchVideos() async {
    setState(() {
      isLoading = true;
    });
    List<Video> newVideos = await josekiApiService.getVideos(joseki);
    setState(() {
      if (newVideos.isEmpty) {
        errorMessage = AppLocalizations.of(context)!.message_video_not_found;
      } else {
        errorMessage = "";
      }
      videos = newVideos;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GobanState gobanState = ref.watch(gobanStateNotifierProvider);
    joseki = gobanState.joseki;

    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomMenu(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          children: [
            Container(
              alignment: Alignment.center,
              child: Goban(),
            ),
            Button(
              text: AppLocalizations.of(context)!.button_search,
              onPressed: isLoading ? null : fetchVideos,
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
                          videos.isEmpty
                              ? [Text(errorMessage)]
                              : videos
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
