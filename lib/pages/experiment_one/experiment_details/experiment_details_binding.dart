import 'package:get/get.dart';

import 'experiment_details_logic.dart';

class ExperimentDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExperimentDetailsLogic());
  }
}
