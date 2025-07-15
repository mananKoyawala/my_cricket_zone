import 'package:flutter/material.dart';
import 'package:interview/controller/create_match_controller.dart';
import 'package:interview/utils/common/PackageConstants.dart';
import 'package:interview/utils/common/TextFormField.dart';
import 'package:interview/utils/common/Text_Button.dart';
import 'package:interview/utils/common/Utils.dart';
import 'package:get/get.dart';
import 'package:interview/utils/common/dismiss_loader.dart';

class CreateMatchScreen extends StatefulWidget {
  CreateMatchScreen({super.key});

  @override
  State<CreateMatchScreen> createState() => _CreateMatchScreenState();
}

class _CreateMatchScreenState extends State<CreateMatchScreen> {
  CreateMatchContoller controller = Get.put(CreateMatchContoller());

  @override
  Widget build(BuildContext context) {
    controller.loadItems();
    return DismissLoader(
      onBack: () {
        controller.resetAll();
      },
      child: Scaffold(
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
                  text(text: "Create a new match", fontSize: 26, fontWeight: 5),
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
                            text(text: "Date of match", fontSize: 18),
                            text(
                                text: "*", fontSize: 18, textColor: Colors.red),
                          ],
                        ),
                        sizeH10(),
                        textFormField(
                          context: context,
                          readOnly: true,
                          onTap: () {
                            controller.pickDate(context);
                          },
                          suffixIcon: const Icon(
                            Icons.date_range,
                            color: Colors.purple,
                          ),
                          controller: controller.dateCtr,
                          funValidate: (val) => Validator.fieldRequired(val),
                          isborder: true,
                          hintText: "Please select date",
                        ),
                        sizeH25(),
                        Row(
                          children: [
                            text(text: "Place", fontSize: 18),
                            text(
                                text: "*", fontSize: 18, textColor: Colors.red),
                          ],
                        ),
                        sizeH10(),
                        textFormField(
                          context: context,
                          controller: controller.placeCtr,
                          funValidate: (val) => Validator.fieldRequired(val),
                          isborder: true,
                          maxLines: 3,
                          hintText: "Enter address",
                        ),
                        sizeH25(),
                        Row(
                          children: [
                            text(text: "Total overs", fontSize: 18),
                            text(
                                text: "*", fontSize: 18, textColor: Colors.red),
                          ],
                        ),
                        sizeH10(),
                        textFormField(
                          context: context,
                          onlyNumbers: true,
                          maxLength: 2,
                          controller: controller.totalOverCtr,
                          funValidate: (val) => Validator.fieldRequired(val),
                          isborder: true,
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          maxLines: 1,
                          hintText: "Enter overs per match",
                        ),
                        GetBuilder<CreateMatchContoller>(
                          builder: (controller) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                sizeH25(),
                                Row(
                                  children: [
                                    text(text: "First team", fontSize: 18),
                                    text(
                                        text: "*",
                                        fontSize: 18,
                                        textColor: Colors.red),
                                  ],
                                ),
                                sizeH10(),
                                DropdownButtonFormField<String>(
                                  validator: (value) =>
                                      Validator.fieldRequired(value),
                                  icon: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Colors.purple,
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[700],
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: const EdgeInsets.only(
                                      top: 20,
                                      bottom: 20,
                                      left: 24,
                                      right: 10,
                                    ),
                                    errorStyle: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    hintText: "Please select team",
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[700],
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.purple,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.purple,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.purple,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.purple,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.purple,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  value: controller.selected_team_A,
                                  items: controller.teamA.map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    controller.changeTeamA(newValue);
                                  },
                                ),
                                sizeH25(),
                                Row(
                                  children: [
                                    text(text: "Second team", fontSize: 18),
                                    text(
                                        text: "*",
                                        fontSize: 18,
                                        textColor: Colors.red),
                                  ],
                                ),
                                sizeH10(),
                                DropdownButtonFormField<String>(
                                  validator: (value) =>
                                      Validator.fieldRequired(value),
                                  icon: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Colors.purple,
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[700],
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: const EdgeInsets.only(
                                      top: 20,
                                      bottom: 20,
                                      left: 24,
                                      right: 10,
                                    ),
                                    errorStyle: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    hintText: "Please select team",
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[700],
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.purple,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.purple,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.purple,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.purple,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.purple,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  value: controller.selected_team_B,
                                  items: controller.teamB.map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    controller.changeTeamB(newValue);
                                  },
                                )
                              ],
                            );
                          },
                        )
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
                  title: "Create Team"),
              sizeH25(),
            ],
          ),
        ),
      ),
    );
  }
}
