import 'package:get/get.dart';

import 'custom_type_add_logic.dart';

class CustomTypeAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomTypeAddLogic());
  }
}
