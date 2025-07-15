import 'package:get/get.dart';
import 'package:interview/db_helper/db_helper.dart';
import 'package:interview/models/match_with_teams_model.dart';

class AllMatchController extends GetxController {
  DBHelper helper = DBHelper();
  var loading = false.obs;
  var matches = <MatchWithTeams>[].obs;
  loadMatches() async {
    loading.value = true;
    var list = await helper.getAllMatchesWithTeams();
    printMatches(list);
    matches.value = list;
    loading.value = false;
  }

  resetAll() {
    loading.value = false;
    matches.clear();
  }

  void printMatches(List<MatchWithTeams> matches) {
    for (var match in matches) {
      print('📅 Match ID: ${match.id}');
      print('🗓️ Date: ${match.date}');
      print('📍 Place: ${match.place}');
      print('🏏 Overs: ${match.total_overs}');

      print('\n🔵 Team A:');
      for (var team in match.team_a) {
        print(' - Name: ${team.name}');
        print(' - Description: ${team.description}');
        for (var player in team.teamMembers) {
          print(
              '   👤 Player: ${player.name}, Age: ${player.age}, Height: ${player.height}');
        }
      }

      print('\n🔴 Team B:');
      for (var team in match.team_b) {
        print(' - Name: ${team.name}');
        print(' - Description: ${team.description}');
        for (var player in team.teamMembers) {
          print(
              '   👤 Player: ${player.name}, Age: ${player.age}, Height: ${player.height}');
        }
      }

      print('\n===============================\n');
    }
  }
}
