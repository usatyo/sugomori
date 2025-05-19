import 'package:flutter/material.dart';
import 'package:frontend/components/atoms/button.dart';
import 'package:frontend/components/bottom_menu.dart';
import 'package:frontend/components/goban.dart';
import 'package:frontend/models/joseki.dart';
import 'package:frontend/services/joseki_api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  JosekiApiService josekiApiService = JosekiApiService.instance;
  String videoId = "";
  Joseki joseki = Joseki([]);

  void onChangeUrl(String url) {
    setState(() {
      Uri uri = Uri.parse(url);
      if (uri.host != "www.youtube.com" && uri.host != "youtu.be") {
        videoId = "";
        return;
      }
      videoId = uri.queryParameters['v'] ?? "";
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
            Container(
              alignment: Alignment.center,
              child: Goban(joseki: joseki),
            ),
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
            Button(
              text: "登録",
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
