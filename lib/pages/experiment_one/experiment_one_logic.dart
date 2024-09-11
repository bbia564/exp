import 'package:experiment/db_experiment/db_experiment.dart';
import 'package:get/get.dart';

import '../../db_experiment/experiment_entity.dart';

class ExperimentOneLogic extends GetxController {

  DBExperiment dbExperiment = Get.find<DBExperiment>();

  var list = <ExperimentTypeEntity>[].obs;

  void getData() async {
    final result = await dbExperiment.getExperimentAllData();
    var hereList = <ExperimentTypeEntity>[];
    final experimentTypes = await dbExperiment.getExperimentTypeAllData();
    for (var e in experimentTypes) {
      List<ExperimentEntity> temp = [];
      for (var e2 in result) {
        if (e2.type.id == e.id) {
          temp.add(e2);
        }
      }
      e.list = temp;
      if (temp.isEmpty && e.isHidden == 1) {

      } else {
        hereList.add(e);
      }
    }
    list.value = hereList;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

}
