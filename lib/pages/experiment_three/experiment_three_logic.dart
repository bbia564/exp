import 'dart:math';

import 'package:experiment/db_experiment/db_experiment.dart';
import 'package:experiment/pages/experiment_one/experiment_one_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ExperimentThreeLogic extends GetxController {

  DBExperiment dbExperiment = Get.find<DBExperiment>();

  cleanExperimentData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to clean all data?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () async {
            await dbExperiment.cleanExperimentAllData();
            await dbExperiment.cleanExperimentTypeAllData();
            ExperimentOneLogic logic = Get.find<ExperimentOneLogic>();
            logic.getData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  aboutExperimentPrivacy(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Privacy Policy"),
          ),
          body: const Markdown(data: """
#### Data Collection
Our apps do not collect any personal information or user data. All event logs are executed locally on the device and are not transmitted to any external server.

#### Cookie Usage
Our app does not use any form of cookies or similar technologies to track user behavior or personal information.

#### Data Security
User input data is only used for calculations on the user's device and is not stored or transmitted. We are committed to ensuring the security of user data.

#### Contact Information
If you have any questions or concerns about our privacy policy, please contact us via email.
          """),
        );
      },
    );
  }

  aboutExperimentApp(BuildContext context) async {
    var info = await PackageInfo.fromPlatform();
    showAboutDialog(
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/launcher.webp',
        width: 75,
        height: 75,
      ),
      children: [
        const Text(
            """We can provide you with the simple records you need for your experiment"""),
      ],
      context: context,
    );
  }

}
