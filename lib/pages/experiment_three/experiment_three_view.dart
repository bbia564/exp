import 'package:experiment/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'experiment_three_logic.dart';

class ExperimentThreePage extends GetView<ExperimentThreeLogic> {
  Widget _item(int index, BuildContext context) {
    final contents = ['Custom Type','Delete records', 'About APP'];
    return GestureDetector(
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: <Widget>[
          Text(
            contents[index],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Visibility(
              visible: index == 0,
              child: const Icon(
                Icons.keyboard_arrow_right,
                size: 20,
                color: Colors.grey,
              ))
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
      ),
      onTap: () {
        switch (index) {
          case 0:
            Get.toNamed('/customTypeAdd');
            break;
          case 1:
            controller.cleanExperimentData();
            break;
          case 2:
            controller.aboutExperimentApp(context);
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(child: _item(0, context)).decorated(
                color: bgColor, borderRadius: BorderRadius.circular(12)),
            const SizedBox(
              height: 15,
            ),
            Container(
              child: <Widget>[
                _item(1, context),
                _item(2, context),
              ].toColumn(
                  separator: Divider(
                height: 6,
                indent: 15,
                endIndent: 15,
                color: Colors.grey.withOpacity(0.3),
              )),
            ).decorated(
                color: bgColor, borderRadius: BorderRadius.circular(12))
          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }
}
