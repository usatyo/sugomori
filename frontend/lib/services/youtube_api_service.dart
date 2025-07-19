import 'dart:convert';
import 'dart:io';

import 'package:frontend/models/youtube.dart';
import 'package:http/http.dart' as http;

class YoutubeApiService {
  YoutubeApiService._instantiate();

  static final YoutubeApiService instance = YoutubeApiService._instantiate();

  final String _baseUrl = 'www.googleapis.com';

  Future<List<Video>> getVideosById({required List<String> videoIds}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'id': videoIds.join(','),
      'maxResults': '8',
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

      List<Video> videos = [];
      for (var json in videosJson) {
        videos.add(Video.fromMap(json));
      }
      return videos;
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
