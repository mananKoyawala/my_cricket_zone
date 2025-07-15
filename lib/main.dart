import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview/controller/add_team_controller.dart';
import 'package:interview/screens/dashboard_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
      builder: EasyLoading.init(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          );
        },
      ),
    );
  }
}
