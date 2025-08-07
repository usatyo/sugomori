import 'dart:convert';
import 'dart:io';

import 'package:frontend/models/youtube.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class YoutubeApiService {
  YoutubeApiService._instantiate();

  static final YoutubeApiService instance = YoutubeApiService._instantiate();

  final String _baseUrl = 'www.googleapis.com';

  Future<List<Video>> getVideosById({required List<String> videoIds}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguageCode = prefs.getString('languageCode');
    Map<String, String> parameters = {
      'part': 'snippet',
      'id': videoIds.join(','),
      'maxResults': '8',
      'hl': savedLanguageCode ?? 'ja',
      'key': const String.fromEnvironment("YOUTUBE_API_KEY"),
    };
    Uri uri = Uri.https(_baseUrl, '/youtube/v3/videos', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List<dynamic> videosJson = data['items'];

      List<PartVideo> partVideos = [];
      List<String> channelIds = [];
      List<Video> videos = [];
      for (var json in videosJson) {
        partVideos.add(PartVideo.fromMap(json));
        channelIds.add(json['snippet']['channelId']);
      }
      List<Channel> channels = await _getChannelsById(channelIds: channelIds);
      for (int i = 0; i < partVideos.length; i++) {
        int channelIndex = channels.indexWhere(
          (channel) => channel.id == channelIds[i],
        );
        Channel channel = channels[channelIndex];
        videos.add(Video.fromMap(partVideos[i], channel));
      }
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Channel>> _getChannelsById({
    required List<String> channelIds,
  }) async {
    if (channelIds.isEmpty) {
      return [];
    }
    Map<String, String> parameters = {
      'part': 'snippet',
      'id': channelIds.join(','),
      'maxResults': '8',
      'key': const String.fromEnvironment("YOUTUBE_API_KEY"),
    };
    Uri uri = Uri.https(_baseUrl, '/youtube/v3/channels', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> channelsJson = data['items'];

      List<Channel> channels = [];
      for (var json in channelsJson) {
        channels.add(Channel.fromMap(json));
      }
      return channels;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> getVideosByWord(String word) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'q': word,
      'type': 'video',
      'maxResults': '8',
      'key': const String.fromEnvironment("YOUTUBE_API_KEY"),
    };
    Uri uri = Uri.https(_baseUrl, '/youtube/v3/search', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> videosArray = data['items'];
      List<String> videoIds = [];
      for (var json in videosArray) {
        videoIds.add(json["id"]["videoId"].toString());
      }
      return await getVideosById(videoIds: videoIds);
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
