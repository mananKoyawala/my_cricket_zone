import 'package:get/get.dart';
import 'package:interview/db_helper/db_helper.dart';
import 'package:interview/models/score_board_model.dart';
import 'package:interview/utils/common/PackageConstants.dart';

class ScoreBoardController extends GetxController {
  DBHelper helper = DBHelper();
  var loading = false.obs;
  var scores = <ScoreBoardModel>[].obs;

  loadMatcheScores() async {
    loading.value = true;
    var list = await helper.getAllMatcheScore();

    List<ScoreBoardModel> filtered = [];

    for (final match in list) {
      final teamAScore =
          await helper.getMatchScore(match.team_a.first.id, match.id);
      final teamBScore =
          await helper.getMatchScore(match.team_b.first.id, match.id);

      final totalRunATeam = teamAScore.fold(0, (total, e) => total + e.run);
      final totalRunBTeam = teamBScore.fold(0, (total, e) => total + e.run);
      final totalBallATeam = teamAScore.fold(0, (total, e) => total + e.ball);
      final totalBallBTeam = teamBScore.fold(0, (total, e) => total + e.ball);

      final totalBallsInInnings = int.parse(match.total_overs) * 6;
      final totalWicketsATeam = teamAScore.where((e) => e.out == 1).length;
      final totalWicketsBTeam = teamBScore.where((e) => e.out == 1).length;

      // Match not started:
      final matchNotStarted = totalRunATeam == 0 &&
          totalRunBTeam == 0 &&
          totalBallATeam == 0 &&
          totalBallBTeam == 0;

      if (matchNotStarted) {
        printDebug("skip: ${match.id}");
        continue;
      }

      final isTeamAInningsOver =
          totalBallATeam >= totalBallsInInnings || totalWicketsATeam >= 10;
      final isTeamBInningsOver =
          totalBallBTeam >= totalBallsInInnings || totalWicketsBTeam >= 10;

      final matchCompleted = isTeamAInningsOver && isTeamBInningsOver;

      bool wonByTeamA = false;
      int winByRun = 0;

      if (matchCompleted) {
        if (totalRunATeam > totalRunBTeam) {
          wonByTeamA = true;
          winByRun = totalRunATeam - totalRunBTeam;
        } else {
          wonByTeamA = false;
          winByRun = totalRunBTeam - totalRunATeam;
        }
      }

      final updatedMatch = match.copyWith(
        totalRunATeam: totalRunATeam,
        totalRunBTeam: totalRunBTeam,
        totalBallATeam: totalBallATeam,
        totalBallBTeam: totalBallBTeam,
        isMatchStarted: true,
        matchCompleted: matchCompleted,
        wonByTeamA: wonByTeamA,
        winByRun: winByRun,
      );

      filtered.add(updatedMatch);
    }

    scores.value = filtered;
    loading.value = false;
  }

  resetAll() {
    loading.value = false;
    scores.clear();
  }
}
