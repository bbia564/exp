import 'package:experiment/pages/experiment_one/experiment_one_logic.dart';
import 'package:experiment/pages/experiment_three/experiment_three_logic.dart';
import 'package:get/get.dart';

import 'experiment_tab_logic.dart';

class ExperimentTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExperimentTabLogic());
    Get.lazyPut(() => ExperimentOneLogic());
    Get.lazyPut(() => ExperimentThreeLogic());
  }
}
