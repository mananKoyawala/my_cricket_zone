class MatchModel {
  final String id;
  final String date;
  final String place;
  final String total_overs;
  final int team_a_id;
  final int team_b_id;

  MatchModel(
      {required this.id,
      required this.date,
      required this.place,
      required this.total_overs,
      required this.team_a_id,
      required this.team_b_id});
}
