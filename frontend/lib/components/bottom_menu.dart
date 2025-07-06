import 'package:flutter/material.dart';
import 'package:frontend/components/bottom_menu_item.dart';
import 'package:frontend/l10n/app_localizations.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override
  State<BottomMenu> createState() => MenuBarState();
}

class MenuBarState extends State<BottomMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          BottomMenuItem(
            label: AppLocalizations.of(context)!.menu_search,
            icon: Icons.find_in_page,
            route: "/search",
            selected:
                ModalRoute.of(context)!.settings.name == "/search" ||
                ModalRoute.of(context)!.settings.name == "/detail",
          ),
          BottomMenuItem(
            label: AppLocalizations.of(context)!.menu_register,
            icon: Icons.note_add,
            route: "/register",
            selected: ModalRoute.of(context)!.settings.name == "/register",
          ),
          BottomMenuItem(
            label: AppLocalizations.of(context)!.menu_setting,
            icon: Icons.settings,
            route: "/setting",
            selected: ModalRoute.of(context)!.settings.name == "/setting",
          ),
        ],
      ),
    );
  }
}
