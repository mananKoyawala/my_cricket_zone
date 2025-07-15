import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview/db_helper/db_helper.dart';
import 'package:interview/models/grid_items.dart';
import 'package:interview/screens/add_team_screen.dart';
import 'package:interview/screens/all_match_screen.dart';
import 'package:interview/screens/create_match_screen.dart';
import 'package:interview/screens/list_all_teams_screen.dart';
import 'package:interview/utils/common/PackageConstants.dart';
import 'package:interview/utils/common/RippleEffect/RippleEffectContainer.dart';
import 'package:interview/utils/common/Text_Button.dart';
import 'package:interview/utils/common/Utils.dart';
import 'package:interview/utils/common/dismiss_loader.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  DateTime? _lastBackPressed;

  DBHelper helper = DBHelper();

  List<GridItems> items = [
    GridItems(
        title: "Add new team",
        onTap: () {
          Navigation.pushMaterial(AddTeamScreen());
        }),
    GridItems(
        title: "Show all teams",
        onTap: () {
          Navigation.pushMaterial(const ListAllTeamsScreen());
        }),
    GridItems(
        title: "Create match",
        onTap: () async {
          if ((await DBHelper().getAllTeams()).length <= 1) {
            toast("Not enough teams to create match");
            return;
          }
          Navigation.pushMaterial(CreateMatchScreen());
        }),
    GridItems(
        title: "All matches",
        onTap: () async {
          // printDebug(DBHelper().getAllMatches());
          Navigation.pushMaterial(AllMatchScreen());
        }),
  ];
  @override
  Widget build(BuildContext context) {
    return DismissLoader(
      canPop: false,
      onBack: () {
        if (_lastBackPressed == null ||
            DateTime.now().difference(_lastBackPressed!) >
                const Duration(seconds: 2)) {
          toast("Press back again to exit");
          _lastBackPressed = DateTime.now();
        } else {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CP(
          h: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizeH(55),
              text(text: "My Cricket zone", fontSize: 26, fontWeight: 7),
              sizeH25(),
              Expanded(
                  child: GridView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.all(0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return ClickEffect(
                    onTap: () => items[index].onTap(),
                    borderRadius: radius(10),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.purple.shade100,
                          borderRadius: radius(10)),
                      child: text(
                        text: items[index].title,
                        fontWeight: 5,
                        fontSize: 22,
                      ),
                    ),
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
