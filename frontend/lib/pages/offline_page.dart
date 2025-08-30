import 'package:flutter/material.dart';
import 'package:frontend/components/atoms/button.dart';
import 'package:frontend/main.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key, required this.checkConnectivity});

  final Future<void> Function() checkConnectivity;

  Future<void> onTapButton(BuildContext context) async {
    await checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            context.isTablet()
                ? EdgeInsets.symmetric(horizontal: 110)
                : EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("you are offline."),
              SizedBox(height: 16),
              Button(
                text: "Retry",
                onPressed: () async {
                  await onTapButton(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
