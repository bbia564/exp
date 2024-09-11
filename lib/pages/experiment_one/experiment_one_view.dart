import 'package:experiment/pages/experiment_one/one_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'experiment_one_logic.dart';

class ExperimentOnePage extends GetView<ExperimentOneLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Obx(() {
          return controller.list.isEmpty
              ? Center(
                  child: GestureDetector(
                    child: <Widget>[
                      Image.asset(
                        'assets/noData.webp',
                        width: 57,
                        height: 57,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'If no custom type is added, go to add',
                        style: TextStyle(fontSize: 15,color: Colors.grey),
                      ),
                    ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
                    onTap: () {
                      Get.toNamed('/customTypeAdd')?.then((_) {
                        controller.getData();
                      });
                    },
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.list.length,
                  itemBuilder: (_, index) {
                    final entity = controller.list[index];
                    return OneItem(
                      entity,
                      onRefresh: () {
                        controller.getData();
                      },
                    );
                  });
        }).marginAll(15),
      ),
    );
  }
}
