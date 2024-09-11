import 'package:experiment/pages/experiment_one/experiment_one_logic.dart';
import 'package:experiment/pages/experiment_one/experiment_one_view.dart';
import 'package:experiment/pages/experiment_three/experiment_three_view.dart';
import 'package:experiment/pages/experiment_two/experiment_two_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import 'experiment_tab_logic.dart';

class ExperimentTabPage extends GetView<ExperimentTabLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          ExperimentOnePage(),
          ExperimentTwoPage(),
          ExperimentThreePage()
        ],
      ),
      bottomNavigationBar: Obx(()=>_navExBars()),
    );
  }

  Widget _navExBars() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled,color: Colors.grey.withOpacity(0.6)),
          activeIcon:Icon(Icons.home_filled,color: primaryColor),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon:Icon(Icons.add_circle,color: primaryColor,size: 48,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings,color: Colors.grey.withOpacity(0.6)),
          activeIcon:Icon(Icons.settings,color: primaryColor),
          label: 'Setting',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        if (index == 1) {
          Get.toNamed('/experimentTwo')?.then((_) {
            ExperimentOneLogic logic = Get.find<ExperimentOneLogic>();
            logic.getData();
          });
        } else {
          controller.currentIndex.value = index;
          controller.pageController.jumpToPage(index);
          if (index == 0) {
            ExperimentOneLogic logic = Get.find<ExperimentOneLogic>();
            logic.getData();
          }
        }
      },
    );
  }
}
