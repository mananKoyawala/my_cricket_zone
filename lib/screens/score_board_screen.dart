import 'package:flutter/material.dart';
import 'package:interview/controller/score_board_controller.dart';
import 'package:interview/models/match_with_teams_model.dart';
import 'package:interview/models/score_board_model.dart';
import 'package:interview/screens/score_list_screen.dart';
import 'package:interview/utils/common/PackageConstants.dart';
import 'package:interview/utils/common/RippleEffect/RippleEffectContainer.dart';
import 'package:interview/utils/common/Text_Button.dart';
import 'package:interview/utils/common/Utils.dart';
import 'package:get/get.dart';

class ScoreBoardScreen extends StatelessWidget {
  ScoreBoardController controller = Get.put(ScoreBoardController());
  @override
  Widget build(BuildContext context) {
    controller.loadMatcheScores();
    return Scaffold(
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
                text(text: "Score board", fontSize: 22, fontWeight: 5),
              ],
            ),
          ),
          sizeH25(),
          Obx(
            () => Expanded(
                child: CP(
              h: 16,
              child: controller.loading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.scores.isEmpty
                      ? Center(
                          child: text(
                            text: "There is no live match",
                            fontSize: 20,
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: controller.scores.length,
                          itemBuilder: (context, index) {
                            final score = controller.scores[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: radius(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      offset:
                                          const Offset(4, 4), // bottom right
                                      blurRadius: 6,
                                      spreadRadius: .5,
                                    ),
                                  ]),
                              child: ClickEffect(
                                onTap: () {
                                  Navigation.pushMaterial(ScoreListScreen(
                                      match: MatchWithTeams(
                                          id: score.id,
                                          date: score.date,
                                          place: score.date,
                                          total_overs: score.total_overs,
                                          team_a: score.team_a,
                                          team_b: score.team_b),
                                      match_number: score.id));
                                },
                                borderRadius: radius(10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  width: getScreenWidth(context),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          text(
                                              text: "Match id ${score.id}",
                                              fontSize: 18),
                                          const Icon(
                                            Icons.info_outline,
                                            color: Colors.purple,
                                          )
                                        ],
                                      ),
                                      sizeH10(),
                                      text(
                                          text:
                                              "${score.teamAName} vs ${score.teamBName}",
                                          fontSize: 18,
                                          textColor: Colors.purple,
                                          fontWeight: 7),
                                      sizeH10(),
                                      Row(
                                        children: [
                                          text(
                                              text:
                                                  "Team ${score.teamAName} score :- ",
                                              fontSize: 20,
                                              fontWeight: 5),
                                          text(
                                              text:
                                                  "${score.totalRunATeam}-${score.totalBallATeam}",
                                              fontSize: 20,
                                              fontWeight: 7,
                                              textColor: Colors.blue)
                                        ],
                                      ),
                                      sizeH10(),
                                      Row(
                                        children: [
                                          text(
                                              text:
                                                  "Team ${score.teamBName} score :- ",
                                              fontSize: 20,
                                              fontWeight: 5),
                                          text(
                                              text:
                                                  "${score.totalRunBTeam}-${score.totalBallBTeam}",
                                              fontSize: 20,
                                              fontWeight: 7,
                                              textColor: Colors.green)
                                        ],
                                      ),
                                      score.isMatchCompleted
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                top: 10,
                                              ),
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        Colors.purple.shade300,
                                                    width: 2),
                                                borderRadius: radius(5),
                                              ),
                                              child: text(
                                                  text:
                                                      getMatchCompleted(score),
                                                  fontSize: 18,
                                                  textColor: Colors.purple,
                                                  fontWeight: 7),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            )),
          ),
          sizeH25(),
        ],
      ),
    );
  }

  String getMatchCompleted(ScoreBoardModel score) {
    if (!score.isMatchCompleted) return "";

    if (score.totalRunATeam == score.totalRunBTeam) {
      return "Match Tied";
    } else if (score.wonByTeamA) {
      return "${score.teamAName} won by ${score.winByRun} runs";
    } else {
      return "${score.teamBName} won by ${score.winByRun} runs";
    }
  }
}
