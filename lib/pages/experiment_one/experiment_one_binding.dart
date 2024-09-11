import 'package:get/get.dart';

import 'experiment_one_logic.dart';

class ExperimentOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExperimentOneLogic());
  }
}
