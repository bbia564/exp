import 'package:experiment/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'experiment_details_logic.dart';

class ExperimentDetailsPage extends GetView<ExperimentDetailsLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment details'),
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            child: Icon(
              Icons.delete_forever,
              color: primaryColor,
              size: 25,
            ).marginOnly(right: 20),
            onTap: () async {
              await controller.dbExperiment.deleteExperiment(controller.entity);
              Get.back();
            },
          )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<ExperimentDetailsLogic>(builder: (_) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  controller.entity.imageData,
                  width: double.infinity,
                  height: 284,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 15,),
              Container(
                padding: const EdgeInsets.all(12),
                child: <Widget>[
                  <Widget>[
                    Flexible(
                      child: Text(
                        controller.entity.name,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      child: Text(
                        controller.entity.success == 0 ? 'Failed' : 'Success',
                        style: TextStyle(
                            color: controller.entity.success == 0
                                ? Colors.grey
                                : const Color(0xff0fb916)),
                      ),
                    ).decorated(
                        color: controller.entity.success == 0
                            ? Colors.grey.withOpacity(0.3)
                            : const Color(0xffe3ffe3),
                        borderRadius: BorderRadius.circular(4))
                  ].toRow(),
                  Divider(
                    height: 20,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  <Widget>[
                    const Text(
                      'Experiment time',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      controller.entity.timeString,
                      style:const TextStyle(fontSize: 14, color: Colors.grey),
                    )
                  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  Divider(height: 20,color: Colors.grey.withOpacity(0.3),),
                  const Text(
                    'Experimental conclusion',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 15,),
                  Text(controller.entity.content,style: const TextStyle(fontSize: 12, color: Colors.black,)).marginOnly(bottom: 20)
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
              ).decorated(
                  color: Colors.white, borderRadius: BorderRadius.circular(12))
            ].toColumn(),
          );
        }).marginAll(15)),
      ),
    );
  }
}
