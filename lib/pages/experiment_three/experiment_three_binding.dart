import 'package:get/get.dart';

import 'experiment_three_logic.dart';

class ExperimentThreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExperimentThreeLogic());
  }
}
