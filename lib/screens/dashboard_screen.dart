import 'package:flutter/material.dart';
import 'package:interview/db_helper/db_helper.dart';
import 'package:interview/models/grid_items.dart';
import 'package:interview/screens/add_team_screen.dart';
import 'package:interview/screens/create_match_screen.dart';
import 'package:interview/screens/list_all_teams_screen.dart';
import 'package:interview/utils/common/PackageConstants.dart';
import 'package:interview/utils/common/RippleEffect/RippleEffectContainer.dart';
import 'package:interview/utils/common/Text_Button.dart';
import 'package:interview/utils/common/Utils.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

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
            toast("No enough teams to create match");
            return;
          }
          Navigation.pushMaterial(CreateMatchScreen());
        }),
    GridItems(
        title: "All matches",
        onTap: () async {
          printDebug(DBHelper().getAllMatches());
        }),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  mainAxisSpacing: 15, crossAxisSpacing: 15, crossAxisCount: 2),
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
    );
  }
}
