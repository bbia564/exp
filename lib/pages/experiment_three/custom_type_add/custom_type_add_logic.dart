import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../db_experiment/db_experiment.dart';
import '../../../db_experiment/experiment_entity.dart';

class CustomTypeAddLogic extends GetxController {
  final DBExperiment dbExperiment = Get.find<DBExperiment>();
  
  String name = '';

  var list = <ExperimentTypeEntity>[].obs;

  void getTypes() async {
    final result = await dbExperiment.getExperimentTypeAllData();
    list.value = result.where((e) => e.isHidden == 0).toList();
  }

  void addType(BuildContext context) async {
    if (name.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter');
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    if (list.any((e) => e.name == name && e.isHidden == 0)) {
      Fluttertoast.showToast(msg: 'Already exists');
      return;
    }
    await dbExperiment.dbBase.insert(
      'experiment_type',
      {
        'name': name,
        'create_time': DateTime.now().toIso8601String(),
        'is_hidden': 0,
      },
    );
    name = '';
    update();
    getTypes();
  }

  void deleteType(ExperimentTypeEntity entity) async {
    await dbExperiment.deleteExperimentType(entity);
    getTypes();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getTypes();
    super.onInit();
  }
  
  
}
