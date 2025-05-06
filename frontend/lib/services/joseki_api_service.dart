import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class JosekiApiService {
  JosekiApiService._instantiate();

  static final JosekiApiService instance = JosekiApiService._instantiate();

  final String _baseUrl = const String.fromEnvironment("JOSEKI_API_URL");

  Future<String> fetchPong() async {
    Uri uri = Uri.http(_baseUrl, '/ping');
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
}
