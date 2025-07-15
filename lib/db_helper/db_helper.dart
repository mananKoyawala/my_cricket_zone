import 'package:interview/models/team_model.dart';
import 'package:interview/utils/common/PackageConstants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/team_members_model.dart';

class DBHelper {
  static const team_table = "teams";
  static const team_member_table = "team_members";
  static const match_table = "matches";
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

  Future<List<TeamModel>> getAllTeams() async {
    try {
      final db = await openTeamDatabase();
      final List<Map<String, dynamic>> teamMaps = await db.query(team_table);

      // Step 2: For each team, get its members
      List<TeamModel> teams = [];

      for (var team in teamMaps) {
        final List<Map<String, dynamic>> members = await db.query(
          team_member_table,
          where: "team_id = ?",
          whereArgs: [team['id']],
        );

        // Convert each member to model
        List<TeamMembersModel> teamMembers =
            members.map((member) => TeamMembersModel.fromMap(member)).toList();

        // Convert team + members to TeamModel
        teams.add(TeamModel.fromMap(team, teamMembers));
      }
      return teams;
    } catch (e) {
      return [];
    }
  }
}
