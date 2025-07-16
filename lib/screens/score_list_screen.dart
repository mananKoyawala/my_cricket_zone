import 'package:flutter/material.dart';
import 'package:interview/controller/match_score_controller.dart';
import 'package:interview/models/match_with_teams_model.dart';
import 'package:interview/utils/common/PackageConstants.dart';
import 'package:interview/utils/common/Text_Button.dart';
import 'package:interview/utils/common/Utils.dart';
import 'package:get/get.dart';
import 'package:interview/utils/common/dismiss_loader.dart';

class ScoreListScreen extends StatelessWidget {
  ScoreListScreen({super.key, required this.match, required this.match_number});

  final MatchWithTeams match;
  final String match_number;
  MatchScoreController controller = Get.put(MatchScoreController());
  @override
  Widget build(BuildContext context) {
    controller.initData(match.team_a[0].id, match.team_b[0].id, match.id);
    return DismissLoader(
      onBack: () {
        Get.delete<MatchScoreController>();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            sizeH(55),
            CP(
              h: 16,
              child: Row(
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
                  text(
                      text: "Detailed score for match $match_number",
                      fontSize: 22,
                      fontWeight: 5),
                ],
              ),
            ),
            sizeH10(),
            Expanded(
              child: Obx(
                () => controller.loading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            CP(
                              h: 16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        text(
                                            text:
                                                "Team ${controller.team_A_name.value}",
                                            fontSize: 22,
                                            fontWeight: 7),
                                        sizeH10(),
                                        ...controller.team_A_score
                                            .asMap()
                                            .entries
                                            .map((e) {
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 15),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: radius(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    offset: const Offset(
                                                        4, 4), // bottom right
                                                    blurRadius: 6,
                                                    spreadRadius: .5,
                                                  ),
                                                ]),
                                            child: ListTile(
                                              title: text(
                                                  text: e.value.player_name,
                                                  fontSize: 18,
                                                  fontWeight: 7),
                                              subtitle: Row(
                                                children: [
                                                  text(
                                                      text:
                                                          "Run : ${e.value.run} | Ball : ${e.value.ball} | ",
                                                      fontSize: 16),
                                                  text(
                                                      text: e.value.out == 0
                                                          ? "Not out"
                                                          : "Out",
                                                      fontSize: 16,
                                                      textColor:
                                                          e.value.out == 0
                                                              ? Colors.green
                                                              : Colors.red,
                                                      fontWeight: 5)
                                                ],
                                              ),
                                            ),
                                          );
                                        })
                                      ]),
                                  sizeH25(),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        text(
                                            text:
                                                "Team ${controller.team_B_name.value}",
                                            fontSize: 22,
                                            fontWeight: 7),
                                        sizeH10(),
                                        ...controller.team_B_score
                                            .asMap()
                                            .entries
                                            .map((e) {
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 15),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: radius(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    offset: const Offset(
                                                        4, 4), // bottom right
                                                    blurRadius: 6,
                                                    spreadRadius: .5,
                                                  ),
                                                ]),
                                            child: ListTile(
                                              title: text(
                                                  text: e.value.player_name,
                                                  fontSize: 18,
                                                  fontWeight: 7),
                                              subtitle: Row(
                                                children: [
                                                  text(
                                                      text:
                                                          "Run : ${e.value.run} | Ball : ${e.value.ball} | ",
                                                      fontSize: 16),
                                                  text(
                                                      text: e.value.out == 0
                                                          ? "Not out"
                                                          : "Out",
                                                      fontSize: 16,
                                                      textColor:
                                                          e.value.out == 0
                                                              ? Colors.green
                                                              : Colors.red,
                                                      fontWeight: 5)
                                                ],
                                              ),
                                            ),
                                          );
                                        })
                                      ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            sizeH10(),
          ],
        ),
      ),
    );
  }

  String isOut(int val) {
    return val == 1 ? "Out" : "Not out";
  }
}
