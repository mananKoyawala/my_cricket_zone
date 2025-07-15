import 'package:flutter/material.dart';
import 'package:interview/controller/add_team_controller.dart';
import 'package:interview/utils/common/PackageConstants.dart';
import 'package:interview/utils/common/TextFormField.dart';
import 'package:interview/utils/common/Text_Button.dart';
import 'package:interview/utils/common/Utils.dart';
import 'package:get/get.dart';
import 'package:interview/utils/common/loader.dart';

class AddTeamScreen extends StatefulWidget {
  AddTeamScreen({super.key});

  @override
  State<AddTeamScreen> createState() => _AddTeamScreenState();
}

class _AddTeamScreenState extends State<AddTeamScreen> {
  AddTeamController controller = Get.find<AddTeamController>();

  @override
  void dispose() {
    AppLoader.dismissLoader();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CP(
        h: 16,
        child: Column(
          children: [
            sizeH(50),
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigation.pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 28,
                    )),
                sizeW10(),
                text(text: "Add Team and details", fontSize: 26),
              ],
            ),
            sizeH10(),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizeH10(),
                      Row(
                        children: [
                          text(text: "Team name", fontSize: 18),
                          text(text: "*", fontSize: 18, textColor: Colors.red),
                        ],
                      ),
                      sizeH10(),
                      textFormField(
                        context: context,
                        controller: controller.teamName,
                        funValidate: (val) => Validator.fieldRequired(val),
                        isborder: true,
                        hintText: "Team name",
                      ),
                      sizeH25(),
                      Row(
                        children: [
                          text(text: "Team description", fontSize: 18),
                          text(text: "*", fontSize: 18, textColor: Colors.red),
                        ],
                      ),
                      sizeH10(),
                      textFormField(
                        context: context,
                        controller: controller.teamDescripiton,
                        funValidate: (val) => Validator.fieldRequired(val),
                        isborder: true,
                        maxLines: 3,
                        hintText: "Team description",
                      ),
                      sizeH25(),
                      text(text: "Team members name", fontSize: 20),
                      sizeH25(),
                      ...controller.teamMembers.asMap().entries.map((player) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text(
                                text: "Player ${player.key + 1} details",
                                fontSize: 20),
                            sizeH25(),
                            Row(
                              children: [
                                text(text: "Name", fontSize: 18),
                                text(
                                    text: "*",
                                    fontSize: 18,
                                    textColor: Colors.red),
                              ],
                            ),
                            sizeH10(),
                            textFormField(
                              context: context,
                              controller: player.value.name,
                              funValidate: (val) =>
                                  Validator.fieldRequired(val),
                              isborder: true,
                              hintText: "Name",
                            ),
                            sizeH25(),
                            Row(
                              children: [
                                text(text: "Age", fontSize: 18),
                                text(
                                    text: "*",
                                    fontSize: 18,
                                    textColor: Colors.red),
                              ],
                            ),
                            sizeH10(),
                            textFormField(
                              context: context,
                              controller: player.value.age,
                              funValidate: (val) => controller.validateAge(val),
                              isborder: true,
                              onlyNumbers: true,
                              maxLength: 2,
                              maxLines: 1,
                              textInputType: TextInputType.number,
                              hintText: "Age",
                            ),
                            sizeH25(),
                            Row(
                              children: [
                                text(text: "Height", fontSize: 18),
                                text(
                                    text: "*",
                                    fontSize: 18,
                                    textColor: Colors.red),
                              ],
                            ),
                            sizeH10(),
                            textFormField(
                              context: context,
                              controller: player.value.height,
                              funValidate: (val) =>
                                  controller.validateHeight(val),
                              isborder: true,
                              onlyNumbers: true,
                              maxLength: 3,
                              maxLines: 1,
                              textInputType: TextInputType.number,
                              hintText: "Height (in centimeter)",
                            ),
                            sizeH25(),
                          ],
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
            sizeH25(),
            simpleButton(
                onTap: () {
                  controller.onSubmit();
                },
                title: "Add Team"),
            sizeH25(),
          ],
        ),
      ),
    );
  }
}
