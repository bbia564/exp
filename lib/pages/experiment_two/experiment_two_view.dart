import 'package:experiment/main.dart';
import 'package:experiment/pages/experiment_three/experiment_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'experiment_two_logic.dart';

class ExperimentTwoPage extends GetView<ExperimentTwoLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Additive experiment'),
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<ExperimentTwoLogic>(builder: (_) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: 57,
                  child: <Widget>[
                    const Text(
                      'Type of experiment',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: IgnorePointer(
                      ignoring: true,
                      child: ExperimentTextField(
                          padding: EdgeInsets.zero,
                          textAlign: TextAlign.right,
                          value: controller.typeEntity?.name ?? '',
                          hintText: 'Please select',
                          onChange: (value) {}),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      size: 20,
                      color: Colors.grey,
                    )
                  ].toRow(),
                ).decorated(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                onTap: () {
                  controller.selectType(context);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  height: 144,
                  child: controller.imageData != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            controller.imageData!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : <Widget>[
                          const Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Select picture',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          )
                        ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
                ).decorated(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                onTap: () {
                  controller.imageSelected();
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                // height: 300,
                padding: const EdgeInsets.all(12),
                child: <Widget>[
                  SizedBox(
                    height: 40,
                    child: <Widget>[
                      const Text(
                        'Success or not',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Obx(() {
                        return Switch(
                            value: controller.success.value,
                            activeTrackColor: Colors.green,
                            onChanged: (value) {
                              controller.success.value = value;
                            });
                      })
                    ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  ),
                  Divider(
                    height: 15,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  SizedBox(
                    height: 40,
                    child: <Widget>[
                      const Text(
                        'Experiment name',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Expanded(
                          child: ExperimentTextField(
                              padding: EdgeInsets.zero,
                              maxLength: 12,
                              textAlign: TextAlign.right,
                              value: controller.name,
                              onChange: (value) {
                                controller.name = value;
                              }))
                    ].toRow(),
                  ),
                  Divider(
                    height: 15,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  GestureDetector(
                    child: Container(
                      height: 40,
                      color: Colors.transparent,
                      child: <Widget>[
                        const Text(
                          'Experiment time',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: IgnorePointer(
                          ignoring: true,
                          child: ExperimentTextField(
                              padding: EdgeInsets.zero,
                              textAlign: TextAlign.right,
                              value: controller.dateTimeString,
                              hintText: 'Please select',
                              onChange: (value) {}),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          size: 20,
                          color: Colors.grey,
                        )
                      ].toRow(),
                    ),
                    onTap: () {
                      controller.selectTime(context);
                    },
                  ),
                  Divider(
                    height: 15,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  const Text(
                    'Experimental conclusion',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ExperimentTextField(
                          padding: EdgeInsets.zero,
                          maxLines: 8,
                          maxLength: 500,
                          value: controller.content,
                          onChange: (value) {
                            controller.content = value;
                          })),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: const Text(
                        'Submit experiment',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                        .decorated(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(12))
                        .marginSymmetric(vertical: 20),
                    onTap: () {
                      controller.save(context);
                    },
                  )
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
              ).decorated(
                  color: Colors.white, borderRadius: BorderRadius.circular(12))
            ].toColumn(),
          );
        }).marginAll(12)),
      ),
    );
  }
}
