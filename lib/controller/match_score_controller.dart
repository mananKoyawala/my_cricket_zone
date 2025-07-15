import 'package:get/get.dart';
import 'package:interview/db_helper/db_helper.dart';
import 'package:interview/models/match_score_model.dart';
import 'package:interview/utils/common/PackageConstants.dart';
import 'package:interview/utils/common/loader.dart';

class MatchScoreController extends GetxController {
  var team_A_score = <MatchScoreModel>[].obs;
  var team_B_score = <MatchScoreModel>[].obs;
  var team_A_name = "".obs;
  var team_B_name = "".obs;
  var loading = false.obs;

  late String matchId;
  late String teamAId;
  late String teamBId;
  DBHelper helper = DBHelper();
  loadScores(String team_A_id, String team_B_id, String match_id) async {
    loading.value = true;
    team_A_score.value = await helper.getMatchScore(team_A_id, match_id);
    printDebug(team_A_score);
    team_B_score.value = await helper.getMatchScore(team_B_id, match_id);
    printDebug(team_B_score);
    team_A_name.value = await helper.getTeamNameById(team_A_id);
    team_B_name.value = await helper.getTeamNameById(team_B_id);
    loading.value = false;
  }

  editDetails(String match_id, String team_id, String player_id, int run,
      int ball, int out) async {
    AppLoader.showLoader();
    await helper.editPlayerMatchScore(
        match_id, team_id, player_id, run, ball, out);
    AppLoader.dismissLoader();
  }

  @override
  void onReady() {
    printDebug("GG called");
    loadScores(teamAId, teamBId, matchId);
    super.onReady();
  }

  void initData(String teamA, String teamB, String match) {
    teamAId = teamA;
    teamBId = teamB;
    matchId = match;
  }

  resetAll() {
    team_A_score.clear();
    team_B_score.clear();
  }
}
