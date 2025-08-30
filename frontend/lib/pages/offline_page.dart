import 'package:flutter/material.dart';
import 'package:frontend/components/atoms/button.dart';
import 'package:frontend/l10n/app_localizations.dart';
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
              Icon(Icons.wifi_off, size: 100, color: Colors.grey),
              SizedBox(height: 20),
              Text(AppLocalizations.of(context)!.error_netowork),
              SizedBox(height: 30),
              Button(
                text: AppLocalizations.of(context)!.button_retry,
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
