import 'package:flutter/material.dart';

class CreateTeamMember {
  final TextEditingController name;
  final TextEditingController age;
  final TextEditingController height;

  CreateTeamMember(
      {required this.name, required this.age, required this.height});
}
