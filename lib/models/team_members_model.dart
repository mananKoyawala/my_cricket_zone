class TeamMembersModel {
  final String id;
  final String name;
  final String age;
  final String height;

  TeamMembersModel(
      {required this.id,
      required this.name,
      required this.age,
      required this.height});

  factory TeamMembersModel.fromMap(Map<String, dynamic> json) {
    return TeamMembersModel(
      id: json['id'].toString(),
      name: json['name'],
      age: json['age'],
      height: json['height'],
    );
  }
}
