import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview/db_helper/db_helper.dart';
import 'package:interview/models/team_model.dart';
import 'package:interview/utils/common/PackageConstants.dart';
import 'package:interview/utils/common/Utils.dart';
import 'package:interview/utils/common/loader.dart';
import 'package:intl/intl.dart';

class CreateMatchContoller extends GetxController {
  final formKey = GlobalKey<FormState>();
  final dateCtr = TextEditingController();
  final placeCtr = TextEditingController();
  final totalOverCtr = TextEditingController();
  List<TeamModel> teams = [];
  String? selected_team_A;
  String? selected_team_B;
  List<String> genders = ["A", "B", "C", "D"];
  List<String> teamA = [];
  List<String> teamB = [];
  List<String> allTeams = [];
  int team_A_id = 0;
  int team_B_id = 0;

  DBHelper helper = DBHelper();

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(
        2030,
        12,
        31,
      ),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      dateCtr.text = formattedDate;
    }
  }

  onSubmit() async {
    unfocus();
    try {
      AppLoader.showLoader();
      if (formKey.currentState!.validate()) {
        team_A_id = getId(selected_team_A);
        team_B_id = getId(selected_team_B);
        printDebug(team_A_id);
        printDebug(team_B_id);
        bool created = await helper.createMatch(
            dateCtr.text.trim(),
            placeCtr.text.trim(),
            totalOverCtr.text.trim(),
            team_A_id,
            team_B_id);
        if (created) {
          toast("Match is created");
          Navigation.pop();
          resetAll();
          return;
        }
        toast("Failed to create a match");
        return;
      }
      toast("Please complete all fields");
    } finally {
      AppLoader.dismissLoader();
    }
  }

  changeTeamA(String? val) {
    selected_team_A = val;
    if (selected_team_A != null) {
      teamB = List.from(allTeams);
      teamB.remove(selected_team_A);
    }
    update();
    printList();
  }

  changeTeamB(String? val) {
    selected_team_B = val;
    if (selected_team_B != null) {
      teamA = List.from(allTeams);
      teamA.remove(selected_team_B);
    }
    update();
    printList();
  }

  getId(String? val) {
    return int.parse(teams.firstWhere((team) => team.name == val).id);
  }

  printList() {
    printDebug(allTeams);
    printDebug(teamA);
    printDebug(teamB);
  }

  loadItems() async {
    teams = await helper.getAllTeams();
    printDebug(teams);
    allTeams = teams.map((e) => e.name).toList();
    teamA = List.from(allTeams);
    teamB = List.from(allTeams);
    update();
    printList();
  }

  resetAll() {
    dateCtr.clear();
    placeCtr.clear();
    totalOverCtr.clear();
    selected_team_A = null;
    selected_team_B = null;

    teamA = List.from(allTeams);
    teamB = List.from(allTeams);
  }
}
