import 'package:interview/models/team_model.dart';

class MatchWithTeams {
  final String id;
  final String date;
  final String place;
  final String total_overs;
  final List<TeamModel> team_a;
  final List<TeamModel> team_b;

  MatchWithTeams(
      {required this.id,
      required this.date,
      required this.place,
      required this.total_overs,
      required this.team_a,
      required this.team_b});
}
