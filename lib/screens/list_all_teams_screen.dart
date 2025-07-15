import 'package:flutter/material.dart';
import 'package:interview/db_helper/db_helper.dart';
import 'package:interview/models/team_model.dart';
import 'package:interview/utils/common/PackageConstants.dart';
import 'package:interview/utils/common/RippleEffect/RippleEffectContainer.dart';
import 'package:interview/utils/common/Text_Button.dart';
import 'package:interview/utils/common/Utils.dart';

class ListAllTeamsScreen extends StatefulWidget {
  const ListAllTeamsScreen({super.key});

  @override
  State<ListAllTeamsScreen> createState() => _ListAllTeamsScreenState();
}

class _ListAllTeamsScreenState extends State<ListAllTeamsScreen> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  bool loading = false;

  List<TeamModel> allTeams = [];

  loadData() async {
    setState(() {
      loading = true;
    });
    DBHelper helper = DBHelper();
    final teams = await helper.getAllTeams();
    for (var t in teams) {
      printDebug(t.name);
      printDebug(t.description);
      printDebug("\n");
    }
    setState(() {
      allTeams = teams;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CP(
        h: 16,
        child: RemoveScrollViewColor(
          child: Column(
            children: [
              sizeH(50),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigation.pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 28,
                      )),
                  sizeW10(),
                  text(text: "Add teams", fontSize: 26),
                ],
              ),
              sizeH10(),
              Expanded(
                  child: loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : allTeams.isEmpty
                          ? Center(
                              child: text(
                                  text: "There is no team to show",
                                  fontSize: 20),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(0),
                              itemCount: allTeams.length,
                              itemBuilder: (context, index) {
                                final team = allTeams[index];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: radius(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: const Offset(
                                              4, 4), // bottom right
                                          blurRadius: 6,
                                          spreadRadius: 1,
                                        ),
                                      ]),
                                  child: ClickEffect(
                                    onTap: () {
                                      showPlayers(team);
                                    },
                                    borderRadius: radius(10),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                      width: getScreenWidth(context),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: radius(10),
                                      ),
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.all(0),
                                        title:
                                            text(text: team.name, fontSize: 18),
                                        subtitle: text(
                                            text: team.description,
                                            fontSize: 16),
                                        trailing: iconButton(
                                            onTap: () {
                                              showPlayers(team);
                                            },
                                            icon: const Icon(
                                              Icons.info_outline,
                                              color: Colors.purple,
                                            )),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
              sizeH10(),
            ],
          ),
        ),
      ),
    );
  }

  showPlayers(TeamModel team) {
    showBottomSheets(ClipRRect(
      borderRadius: radius(20),
      child: Container(
        height: getScreenHeight(context) * .6,
        width: getScreenWidth(context),
        child: CP(
          h: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizeH(20),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 5,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade500, borderRadius: radius(50)),
                ),
              ),
              sizeH(20),
              text(
                  text: "Team name : ${team.name}",
                  fontSize: 20,
                  fontWeight: 5),
              sizeH10(),
              text(
                  text: "About team : ${team.description}",
                  fontSize: 20,
                  fontWeight: 5),
              sizeH(15),
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: team.teamMembers.length,
                    itemBuilder: (context, index) {
                      final player = team.teamMembers[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(
                              text: "Player ${index + 1}",
                              fontSize: 18,
                              fontWeight: 5),
                          sizeH(10),
                          text(text: "Name : ${player.name}", fontSize: 16),
                          sizeH10(),
                          text(text: "Age : ${player.age}", fontSize: 16),
                          sizeH10(),
                          text(
                              text: "Height : ${player.height} cm",
                              fontSize: 16),
                          Divider(
                            color: Colors.grey.shade300,
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              sizeH25(),
            ],
          ),
        ),
      ),
    ));
  }
}
