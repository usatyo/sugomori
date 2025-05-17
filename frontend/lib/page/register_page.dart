import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Goban(joseki: joseki),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: FilledButton(
                onPressed: () {
                  josekiApiService.postJoseki(
                    joseki,
                    "PTdC1aVH-LQ",
                  );
                },
                child: Text("register"),
              ),
            ),
          ),
          BottomMenu(),
        ],
      ),
    );
  }
}
