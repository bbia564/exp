import 'package:experiment/db_experiment/db_experiment.dart';
import 'package:experiment/db_experiment/experiment_entity.dart';
import 'package:get/get.dart';

class ExperimentDetailsLogic extends GetxController {

  DBExperiment dbExperiment = Get.find<DBExperiment>();

  ExperimentEntity entity = Get.arguments;

  @override
  void onInit() {
    update();
    super.onInit();
  }

}
