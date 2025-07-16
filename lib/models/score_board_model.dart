import 'package:interview/models/team_model.dart';

class ScoreBoardModel {
  final String id;
  final String date;
  final String place;
  final String total_overs;
  final List<TeamModel> team_a;
  final List<TeamModel> team_b;
  final int totalRunATeam;
  final int totalRunBTeam;
  final int totalBallATeam;
  final int totalBallBTeam;
  final bool
      isMatchStarted; // based on total runs of both team is 0 and no players is out
  final String teamAName;
  final String teamBName;
  final bool isMatchCompleted;
  final bool wonByTeamA;
  final int winByRun;

  ScoreBoardModel({
    required this.id,
    required this.totalRunATeam,
    required this.totalRunBTeam,
    required this.isMatchStarted,
    required this.date,
    required this.place,
    required this.total_overs,
    required this.team_a,
    required this.team_b,
    required this.totalBallATeam,
    required this.totalBallBTeam,
    required this.teamAName,
    required this.teamBName,
    required this.isMatchCompleted,
    required this.wonByTeamA,
    required this.winByRun,
  });

  ScoreBoardModel copyWith({
    String? id,
    String? date,
    String? place,
    String? total_overs,
    List<TeamModel>? team_a,
    List<TeamModel>? team_b,
    int? totalRunATeam,
    int? totalRunBTeam,
    int? totalBallATeam,
    int? totalBallBTeam,
    bool? isMatchStarted,
    String? teamAName,
    String? teamBName,
    bool? matchCompleted,
    bool? wonByTeamA,
    int? winByRun,
  }) {
    return ScoreBoardModel(
      id: id ?? this.id,
      totalRunATeam: totalRunATeam ?? this.totalRunATeam,
      totalRunBTeam: totalRunBTeam ?? this.totalRunBTeam,
      isMatchStarted: isMatchStarted ?? this.isMatchStarted,
      date: date ?? this.date,
      place: place ?? this.place,
      total_overs: total_overs ?? this.total_overs,
      team_a: team_a ?? this.team_a,
      team_b: team_b ?? this.team_b,
      totalBallATeam: totalBallATeam ?? this.totalBallATeam,
      totalBallBTeam: totalBallBTeam ?? this.totalBallBTeam,
      teamAName: teamAName ?? this.teamAName,
      teamBName: teamBName ?? this.teamBName,
      isMatchCompleted: matchCompleted ?? this.isMatchCompleted,
      wonByTeamA: wonByTeamA ?? this.wonByTeamA,
      winByRun: winByRun ?? this.winByRun,
    );
  }
}
