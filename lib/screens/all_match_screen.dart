import 'package:flutter/material.dart';
import 'package:interview/controller/all_match_controller.dart';
import 'package:get/get.dart';
import 'package:interview/screens/match_score_screen.dart';
import 'package:interview/models/match_with_teams_model.dart';
import 'package:interview/utils/common/PackageConstants.dart';
import 'package:interview/utils/common/RippleEffect/RippleEffectContainer.dart';
import 'package:interview/utils/common/Text_Button.dart';
import 'package:interview/utils/common/Utils.dart';
import 'package:interview/utils/common/dismiss_loader.dart';

class AllMatchScreen extends StatelessWidget {
  AllMatchScreen({super.key});
  AllMatchController controller = Get.put(AllMatchController());
  @override
  Widget build(BuildContext context) {
    controller.loadMatches();
    return DismissLoader(
      onBack: () {
        controller.resetAll();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CP(
          h: 16,
          child: Column(
            children: [
              sizeH(55),
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
                  text(text: "All matches", fontSize: 26, fontWeight: 5),
                ],
              ),
              sizeH10(),
              Obx(
                () => Expanded(
                  child: controller.loading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.matches.isEmpty
                          ? Center(
                              child: text(
                                text: "No match is available",
                                fontSize: 20,
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(0),
                              itemCount: controller.matches.length,
                              itemBuilder: (context, index) {
                                final match = controller.matches[index];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 20),
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
                                      _onClick(match, index);
                                    },
                                    borderRadius: radius(10),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              text(
                                                  text: "Match : ${index + 1}",
                                                  fontSize: 20,
                                                  fontWeight: 7),
                                              InkWell(
                                                  onTap: () {
                                                    _onClick(match, index);
                                                  },
                                                  child: const Icon(
                                                    Icons.info_outline,
                                                    color: Colors.purple,
                                                  ))
                                            ],
                                          ),
                                          sizeH10(),
                                          Row(
                                            children: [
                                              text(
                                                  text: "Date : ${match.date}",
                                                  fontSize: 16),
                                              sizeW(15),
                                              text(
                                                  text:
                                                      "Overs : ${match.total_overs}",
                                                  fontSize: 16),
                                            ],
                                          ),
                                          sizeH10(),
                                          text(
                                              text: "Address : ${match.place}",
                                              fontSize: 16),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onClick(MatchWithTeams match, int index) {
    Navigation.pushMaterial(MatchScoreScreen(
      match: match,
      match_number: (index + 1).toString(),
    ));
  }
}
