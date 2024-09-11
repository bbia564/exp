import 'package:get/get.dart';

import 'exp_set_logic.dart';

class ExpLeaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
