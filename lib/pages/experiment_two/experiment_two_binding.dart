import 'package:get/get.dart';

import 'experiment_two_logic.dart';

class ExperimentTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExperimentTwoLogic());
  }
}
