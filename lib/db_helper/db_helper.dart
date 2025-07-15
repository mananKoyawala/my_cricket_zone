// ignore_for_file: non_constant_identifier_names

import 'package:interview/models/match_score_model.dart';
import 'package:interview/models/match_with_teams_model.dart';
import 'package:interview/models/team_model.dart';
import 'package:interview/utils/common/PackageConstants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/team_members_model.dart';

class DBHelper {
  static const team_table = "teams";
  static const team_member_table = "team_members";
  static const match_table = "matches";
  static const score_table = "scores";

  Future<Database> openTeamDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cricket.db');
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // enable foreign keys
        await db.execute('PRAGMA foreign_keys = ON');
        await db.execute('''
        CREATE TABLE $team_table (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT UNIQUE,description TEXT)
        ''');
        await db.execute('''
        CREATE TABLE $team_member_table (id INTEGER PRIMARY KEY AUTOINCREMENT, team_id INTEGER, name TEXT UNIQUE, age TEXT, height TEXT, FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE)
        ''');
        await db.execute('''
        CREATE TABLE $match_table (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, place TEXT, total_overs TEXT, team_a_id INTEGER, team_b_id INTEGER, FOREIGN KEY (team_a_id) REFERENCES team_members(id) ON DELETE CASCADE, FOREIGN KEY (team_b_id) REFERENCES team_members(id))
        ''');
        await db.execute('''
        CREATE TABLE $score_table (id INTEGER PRIMARY KEY AUTOINCREMENT,match_id INTEGER, team_id INTEGER,  player_id INTEGER,player_name TEXT ,run INTEGER DEFAULT 0, ball INTEGER DEFAULT 0, out INTEGER DEFAULT 0, FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE)
        ''');
      },
    );
    return database;
  }

  Future<bool> checkTeamAndMemberExists(
      String teamName, List<String> members) async {
    final db = await openTeamDatabase();

    try {
      final existing = await db.query(
        team_table,
        where: 'name = ?',
        whereArgs: [teamName],
      );

      if (existing.isNotEmpty) {
        toast("Team already exist with name $teamName");
        return true;
      }

      for (var member in members) {
        final existingMember = await db.query(
          team_member_table,
          where: 'name = ?',
          whereArgs: [member],
        );

        if (existingMember.isNotEmpty) {
          toast("Player already exist with name $member");
          return true;
        }
      }

      return false;
    } catch (e) {
      toast("Failed to create new team");
      return true;
    }
  }

  // create team
  Future<int> createTeam(String teamName, String teamDescription) async {
    try {
      final db = await openTeamDatabase();
      final existing = await db.query(
        team_table,
        where: 'name = ?',
        whereArgs: [teamName],
      );

      if (existing.isNotEmpty) {
        toast("Team already exist with name");
        return 0;
      }

      int id = await db.insert(team_table, {
        "name": teamName,
        "description": teamDescription,
      });

      return id;
    } catch (e) {
      toast("Failed to add team");
      return 0;
    }
  }

  // delete team
  Future<bool> deleteTeam(int teamId) async {
    try {
      final db = await openTeamDatabase();
      int rowsAffected =
          await db.delete(team_table, where: "id=?", whereArgs: [teamId]);
      return rowsAffected != 0;
    } catch (e) {
      return false;
    }
  }

  // add team members
  Future<bool> addTeamMember(
      int teamId, String name, String age, String height) async {
    try {
      final db = await openTeamDatabase();
      final existing = await db.query(
        team_member_table,
        where: 'name = ?',
        whereArgs: [name],
      );

      if (existing.isNotEmpty) {
        toast("Team member already exist with name");
        return false;
      }

      int id = await db.insert(team_member_table, {
        "team_id": teamId,
        "name": name,
        "age": age,
        "height": height,
      });
      return id != 0;
    } catch (e) {
      toast("Failed to add team member");
      return false;
    }
  }

  // delete team members
  Future<bool> deleteTeamMember(int memberId) async {
    try {
      final db = await openTeamDatabase();
      int rowsAffected = await db
          .delete(team_member_table, where: "id=?", whereArgs: [memberId]);
      return rowsAffected != 0;
    } catch (e) {
      return false;
    }
  }

  // get all teams
  Future<List<TeamModel>> getAllTeams() async {
    try {
      final db = await openTeamDatabase();
      final List<Map<String, dynamic>> teamMaps = await db.query(team_table);

      List<TeamModel> teams = [];

      for (var team in teamMaps) {
        final List<Map<String, dynamic>> members = await db.query(
          team_member_table,
          where: "team_id = ?",
          whereArgs: [team['id']],
        );

        List<TeamMembersModel> teamMembers =
            members.map((member) => TeamMembersModel.fromMap(member)).toList();

        teams.add(TeamModel.fromMap(team, teamMembers));
      }
      printDebug(teams);
      return teams;
    } catch (e) {
      return [];
    }
  }

  // create a new match
  Future<bool> createMatch(String date, String place, String total_overs,
      int team_a_id, int team_b_id) async {
    try {
      final db = await openTeamDatabase();
      int id = await db.insert(match_table, {
        "date": date,
        "place": place,
        "total_overs": total_overs,
        "team_a_id": team_a_id,
        "team_b_id": team_b_id,
      });
      if (id != 0) {
        addScore(id, team_a_id);
        addScore(id, team_b_id);
      }
      return id != 0;
    } catch (e) {
      toast("Failed to create a match");
      return false;
    }
  }

  // create score of player
  Future<void> addScore(int match_id, int team_id) async {
    final db = await openTeamDatabase();
    final List<Map<String, dynamic>> members = await db.query(
      team_member_table,
      where: "team_id = ?",
      whereArgs: [team_id],
    );

    List<TeamMembersModel> teamMembers =
        members.map((member) => TeamMembersModel.fromMap(member)).toList();
    for (var player in teamMembers) {
      printDebug(player.name);
      db.insert(score_table, {
        "match_id": match_id,
        "team_id": team_id,
        "player_id": player.id,
        "player_name": player.name,
      });
    }
  }

  // get all matches are available
  Future<List<MatchWithTeams>> getAllMatchesWithTeams() async {
    try {
      final db = await openTeamDatabase();
      // * get all matches
      final matchRows = await db.query(match_table);

      List<MatchWithTeams> matches = [];

      for (var match in matchRows) {
        final int teamAId = match['team_a_id'] as int;
        final int teamBId = match['team_b_id'] as int;

        // * get all team A info
        final teamAData =
            await db.query(team_table, where: 'id = ?', whereArgs: [teamAId]);
        // * get all team A players
        final teamAMembers = await db.query(team_member_table,
            where: 'team_id = ?', whereArgs: [teamAId]);

        // * get all team B info
        final teamBData =
            await db.query(team_table, where: 'id = ?', whereArgs: [teamBId]);
        // * get all team B players
        final teamBMembers = await db.query(team_member_table,
            where: 'team_id = ?', whereArgs: [teamBId]);

        // * create team A list along with players
        final List<TeamModel> teamAList = teamAData.map((teamMap) {
          return TeamModel.fromMap(
            teamMap,
            teamAMembers.map((e) => TeamMembersModel.fromMap(e)).toList(),
          );
        }).toList();

        // * create team B list along with players
        final List<TeamModel> teamBList = teamBData.map((teamMap) {
          return TeamModel.fromMap(
            teamMap,
            teamBMembers.map((e) => TeamMembersModel.fromMap(e)).toList(),
          );
        }).toList();

        // * Create final list
        matches.add(MatchWithTeams(
          id: match['id'].toString(),
          date: match['date'].toString(),
          place: match['place'].toString(),
          total_overs: match['total_overs'].toString(),
          team_a: teamAList,
          team_b: teamBList,
        ));
      }

      return matches;
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<List<MatchScoreModel>> getMatchScore(
      String team_id, String match_id) async {
    final db = await openTeamDatabase();
    final data = await db.query(score_table,
        where: "team_id = ? AND match_id=?", whereArgs: [team_id, match_id]);
    printDebug(data);

    return data.map((e) => MatchScoreModel.fromMap(e)).toList();
  }

  Future<String> getTeamNameById(String id) async {
    final db = await openTeamDatabase();
    final List<Map<String, dynamic>> team =
        await db.query(team_table, where: "id=?", whereArgs: [id]);
    printDebug(team);
    String name = team.isNotEmpty ? team.first["name"] : "";
    return name;
  }

  // edit player score
  Future<bool> editPlayerMatchScore(String match_id, String team_id,
      String player_id, int run, int ball, int isOut) async {
    final db = await openTeamDatabase();
    int rowsAffected = await db.update(
        score_table,
        {
          "run": run,
          "ball": ball,
          "out": isOut,
        },
        where: "match_id=? AND team_id=? AND player_id=?",
        whereArgs: [match_id, team_id, player_id]);
    return rowsAffected != 0;
  }
}
