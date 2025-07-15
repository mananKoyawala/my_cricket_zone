import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview/controller/add_team_controller.dart';
import 'package:interview/screens/dashboard_screen.dart';

void main() {
  runApp(MyCricket());
}

class MyCricket extends StatelessWidget {
  MyCricket({super.key});
  AddTeamController controller = Get.put(AddTeamController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
      theme: ThemeData(primaryColor: Colors.purple),
    );
  }
}
