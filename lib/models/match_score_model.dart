class MatchScoreModel {
  final String id; // * score id
  final String match_id;
  final String team_id;
  final String player_id;
  final String player_name;
  final int run;
  final int ball;
  final int out;

  MatchScoreModel(
      {required this.id,
      required this.match_id,
      required this.team_id,
      required this.player_id,
      required this.run,
      required this.ball,
      required this.player_name,
      required this.out});

  factory MatchScoreModel.fromMap(Map<String, dynamic> map) {
    return MatchScoreModel(
      id: map['id'].toString(),
      match_id: map['match_id'].toString(),
      team_id: map['team_id'].toString(),
      player_id: map['player_id'].toString(),
      player_name: map['player_name'],
      run: map['run'] ?? 0,
      ball: map['ball'] ?? 0,
      out: map['out'] ?? 0,
    );
  }
}
