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
  final String _bearerToken = const String.fromEnvironment(
    "JOSEKI_API_BEARER_TOKEN",
  );

  Uri getUri(String path) {
    if (_bearerToken.isEmpty) {
      return Uri.http(_baseUrl, path);
    } else {
      return Uri.https(_baseUrl, path);
    }
  }

  Future<String> fetchHello() async {
    Uri uri = getUri('/');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $_bearerToken',
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
    Uri uri = getUri('/joseki');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $_bearerToken',
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
    Uri uri = getUri('/video');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $_bearerToken',
    };

    var response = await http.post(
      uri,
      headers: headers,
      body: json.encode(StonesRequest(stones: joseki.stoneList).toJson()),
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
