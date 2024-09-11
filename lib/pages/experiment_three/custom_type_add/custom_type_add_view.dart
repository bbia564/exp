import 'package:experiment/main.dart';
import 'package:experiment/pages/experiment_three/experiment_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'custom_type_add_logic.dart';

class CustomTypeAddPage extends GetView<CustomTypeAddLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Custom type'),
          backgroundColor: Colors.white,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: GetBuilder<CustomTypeAddLogic>(builder: (_) {
            return SafeArea(
                child: <Widget>[
              Container(
                padding: const EdgeInsets.all(12),
                child: <Widget>[
                  SizedBox(
                    height: 40,
                    child: <Widget>[
                      const Text(
                        'Input type',
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff7b7b7b)),
                      ),
                      Expanded(
                          child: ExperimentTextField(
                              padding: EdgeInsets.zero,
                              textAlign: TextAlign.end,
                              maxLength: 12,
                              value: controller.name,
                              onChange: (value) {
                                controller.name = value;
                              }))
                    ].toRow(),
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      child: const Text(
                        'Add',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                        .decorated(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(12))
                        .marginOnly(top: 20, bottom: 10),
                    onTap: () {
                      controller.addType(context);
                    },
                  )
                ].toColumn(),
              ).decorated(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Obx(() {
                  return controller.list.value.isEmpty
                      ? Center(
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
                        'No custom type is added',
                        style: TextStyle(fontSize: 15,color: Colors.grey),
                      ),
                    ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
                  )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: controller.list.value.length,
                          itemBuilder: (_, index) {
                            final entity = controller.list[index];
                            return Container(
                              child: <Widget>[
                                <Widget>[
                                  Expanded(
                                      child: Text(
                                    entity.name,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    child: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                    onTap: () {
                                      controller.deleteType(entity);
                                    },
                                  )
                                ].toRow(),
                                Divider(
                                  height: 25,
                                  color: Colors.grey.withOpacity(0.3),
                                )
                              ].toColumn(),
                            );
                          });
                }),
              ).decorated(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)))
            ].toColumn().marginAll(15));
          }),
        ));
  }
}
