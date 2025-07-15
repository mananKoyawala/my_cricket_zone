import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview/db_helper/db_helper.dart';
import 'package:interview/models/create_member.dart';
import 'package:interview/utils/common/PackageConstants.dart';
import 'package:interview/utils/common/Utils.dart';
import 'package:interview/utils/common/loader.dart';

class AddTeamController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final teamName = TextEditingController();
  final teamDescripiton = TextEditingController();
  DBHelper helper = DBHelper();
  List<String> members = [];
  List<CreateTeamMember> teamMembers = List.generate(
    11,
    (index) {
      return CreateTeamMember(
          name: TextEditingController(),
          age: TextEditingController(),
          height: TextEditingController());
    },
  );

  onSubmit() async {
    unfocus();
    AppLoader.showLoader();
    try {
      if (formKey.currentState!.validate()) {
        members.clear();
        members = teamMembers
            .map((e) => e.name.text.trim())
            .where((name) => name.isNotEmpty)
            .toList();
        var uniquePlayers = members;
        if (!(members.length == uniquePlayers.toSet().length)) {
          toast("Player name must be unique");
          return;
        }
        bool notAllowed = await helper.checkTeamAndMemberExists(
            teamName.text.trim(), members);

        if (notAllowed) {
          return;
        }
        int id = await helper.createTeam(
            teamName.text.trim(), teamDescripiton.text.trim());
        if (id <= 0) {
          return;
        }

        for (var player in teamMembers) {
          bool success = await helper.addTeamMember(id, player.name.text.trim(),
              player.age.text.trim(), player.height.text.trim());
          if (!success) {
            printDebug(">>> Failed to add player ${player.name}");
          }
        }
        toast("Team is added with players");
        resetAll();
        Navigation.pop();
        return;
      }
    } finally {
      AppLoader.dismissLoader();
    }
    toast("Please complete all fields");
  }

  validateAge(String? val) {
    if (val == null || val.isEmpty) {
      return "Player's age is required";
    }
    final age = int.tryParse(val);
    if (age == null) return "Enter a valid number";
    if (!(age >= 16 && age <= 65)) {
      return "Player's age must be between 16-65";
    }

    return null;
  }

  validateHeight(String? val) {
    if (val == null || val.isEmpty) {
      return "Player's height is required";
    }
    final height = int.tryParse(val);
    if (height == null) return "Enter a valid number";
    if (!(height >= 130 && height <= 220)) {
      return "Height must be between 130–220 cm";
    }

    return null;
  }

  resetAll() {
    members.clear();
    teamName.clear();
    teamDescripiton.clear();
    teamMembers.clear();
    teamMembers = List.generate(
      11,
      (index) {
        return CreateTeamMember(
            name: TextEditingController(),
            age: TextEditingController(),
            height: TextEditingController());
      },
    );
  }
}
