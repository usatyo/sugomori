import 'dart:convert';
import 'dart:io';

import 'package:frontend/models/joseki.dart';
import 'package:frontend/models/joseki_api.dart';
import 'package:frontend/models/youtube.dart';
import 'package:frontend/services/youtube_api_service.dart';
import 'package:http/http.dart' as http;

class JosekiApiService {
  JosekiApiService._instantiate();

  static final JosekiApiService instance = JosekiApiService._instantiate();

  final String _baseUrl = const String.fromEnvironment("JOSEKI_API_URL");

  Future<String> fetchHello() async {
    Uri uri = Uri.http(_baseUrl, '/');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      String message = data["message"];
      return message;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<void> postJoseki(Joseki joseki, String videoId) async {
    Uri uri = Uri.http(_baseUrl, '/joseki');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.post(
      uri,
      headers: headers,
      body: json.encode(
        JosekiVideoRequest(stones: joseki.stoneList, videoId: videoId).toJson(),
      ),
    );
    if (response.statusCode == 200) {
      json.decode(response.body);
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> getVideos(Joseki joseki) async {
    Uri uri = Uri.http(_baseUrl, '/video');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.post(
      uri,
      headers: headers,
      body: json.encode(
        StonesRequest(stones: joseki.stoneList).toJson(),
      ),
    );
    if (response.statusCode == 200) {
      YoutubeApiService youtubeApiService = YoutubeApiService.instance;
      var data = json.decode(response.body);

      List<dynamic> videosArray = data['data'];

      List<String> videoIds = [];
      for (var json in videosArray) {
        videoIds.add(json["id"].toString());
      }
      return await youtubeApiService.fetchVideos(videoIds: videoIds);
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
