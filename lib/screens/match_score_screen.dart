import 'package:flutter/material.dart';
import 'package:interview/controller/match_score_controller.dart';
import 'package:interview/models/match_score_model.dart';
import 'package:interview/models/match_with_teams_model.dart';
import 'package:interview/utils/common/PackageConstants.dart';
import 'package:interview/utils/common/RippleEffect/RippleEffectContainer.dart';
import 'package:interview/utils/common/TextFormField.dart';
import 'package:interview/utils/common/Text_Button.dart';
import 'package:interview/utils/common/Utils.dart';
import 'package:get/get.dart';
import 'package:interview/utils/common/dismiss_loader.dart';

class MatchScoreScreen extends StatelessWidget {
  MatchScoreScreen(
      {super.key, required this.match, required this.match_number});

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
                      text: "Score for match $match_number",
                      fontSize: 22,
                      fontWeight: 5),
                ],
              ),
            ),
            sizeH10(),
            // TODO : show only if match is started
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
                              child: Container(
                                height: getScreenHeight(context) * .3,
                                width: getScreenWidth(context),
                                color: Colors.purple.shade100,
                              ),
                            ),
                            sizeH25(),
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
                                            text: controller.team_A_name.value,
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
                                            child: ClickEffect(
                                              onTap: () {
                                                showEditScoreDialog(
                                                    teamName: controller
                                                        .team_A_name.value,
                                                    playerName:
                                                        e.value.player_name,
                                                    context: context,
                                                    scoreModel: e.value,
                                                    onSave: (run, ball, out) {
                                                      controller.editDetails(
                                                          e.value.match_id,
                                                          e.value.team_id,
                                                          e.value.player_id,
                                                          run,
                                                          ball,
                                                          out);
                                                      controller.loadScores(
                                                          match.team_a[0].id,
                                                          match.team_b[0].id,
                                                          match.id);
                                                    });
                                              },
                                              borderRadius: radius(10),
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
                                                trailing: const Icon(Icons.edit,
                                                    color: Colors.purple),
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
                                            text: controller.team_B_name.value,
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
                                            child: ClickEffect(
                                              onTap: () {
                                                showEditScoreDialog(
                                                    teamName: controller
                                                        .team_B_name.value,
                                                    playerName:
                                                        e.value.player_name,
                                                    context: context,
                                                    scoreModel: e.value,
                                                    onSave: (run, ball, out) {
                                                      controller.editDetails(
                                                          e.value.match_id,
                                                          e.value.team_id,
                                                          e.value.player_id,
                                                          run,
                                                          ball,
                                                          out);
                                                      controller.loadScores(
                                                          match.team_a[0].id,
                                                          match.team_b[0].id,
                                                          match.id);
                                                    });
                                              },
                                              borderRadius: radius(10),
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
                                                trailing: const Icon(Icons.edit,
                                                    color: Colors.purple),
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

  void showEditScoreDialog({
    required String teamName,
    required String playerName,
    required BuildContext context,
    required MatchScoreModel scoreModel,
    required Function(int run, int ball, int isOut) onSave,
  }) {
    final runController =
        TextEditingController(text: scoreModel.run.toString());
    final ballController =
        TextEditingController(text: scoreModel.ball.toString());
    final isOut = RxBool(scoreModel.out == 1);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              text(
                  text: teamName,
                  fontSize: 22,
                  textColor: Colors.purple,
                  fontWeight: 5),
              sizeH(10),
              text(
                  text: "Edit score for $playerName",
                  fontSize: 20,
                  fontWeight: 5),
              sizeH(10),
              textFormField(
                context: context,
                controller: runController,
                onlyNumbers: true,
                hintText: "Enter Runs",
                funValidate: (val) => null,
                isborder: true,
                textInputType: TextInputType.number,
              ),
              sizeH(12),
              textFormField(
                context: context,
                controller: ballController,
                onlyNumbers: true,
                hintText: "Enter Balls",
                funValidate: (val) => null,
                isborder: true,
                textInputType: TextInputType.number,
              ),
              sizeH(12),
              Obx(() => Column(
                    children: [
                      RadioListTile<bool>(
                        title: const Text("Out"),
                        value: true,
                        groupValue: isOut.value,
                        onChanged: (val) {
                          isOut.value = val!;
                        },
                      ),
                      RadioListTile<bool>(
                        title: const Text("Not Out"),
                        value: false,
                        groupValue: isOut.value,
                        onChanged: (val) {
                          isOut.value = val!;
                        },
                      ),
                    ],
                  )),
            ],
          ),
          actions: [
            TextButton(
              child:
                  text(text: "Cancel", fontSize: 16, textColor: Colors.purple),
              onPressed: () => Get.back(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              onPressed: () {
                final run = int.tryParse(runController.text.trim()) ?? 0;
                final ball = int.tryParse(ballController.text.trim()) ?? 0;
                onSave(run, ball, isOut.value ? 1 : 0);
                Get.back();
              },
              child: text(text: "Ok", fontSize: 16, textColor: Colors.white),
            )
          ],
        );
      },
    );
  }

  String isOut(int val) {
    return val == 1 ? "Out" : "Not out";
  }
}
