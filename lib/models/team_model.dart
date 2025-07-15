import 'package:interview/models/team_members_model.dart';

class TeamModel {
  final String id;
  final String name;
  final String description;
  final List<TeamMembersModel> teamMembers;

  TeamModel({
    required this.id,
    required this.name,
    required this.description,
    required this.teamMembers,
  });
  factory TeamModel.fromMap(
      Map<String, dynamic> map, List<TeamMembersModel> members) {
    return TeamModel(
      id: map['id'].toString(),
      name: map['name'],
      description: map['description'],
      teamMembers: members,
    );
  }
}
