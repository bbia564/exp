import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../db_experiment/db_experiment.dart';
import '../../db_experiment/experiment_entity.dart';

class ExperimentTwoLogic extends GetxController {
  final DBExperiment dbExperiment = Get.find<DBExperiment>();

  var typeList = <ExperimentTypeEntity>[];
  ExperimentTypeEntity? typeEntity;
  Uint8List? imageData;
  var success = false.obs;
  String name = '';
  DateTime? dateTime;
  String dateTimeString = '';
  String content = '';

  getTypes() async {
    final result = await dbExperiment.getExperimentTypeAllData();
    typeList = result.where((e) => e.isHidden == 0).toList();
  }

  void selectTime(BuildContext context) {
    DatePicker.showDatePicker(context,
        pickerMode: DateTimePickerMode.date,
        dateFormat: 'yyyy-MM-dd', onConfirm: (date, dateList) {
      dateTime = date;
      dateTimeString = DateFormat('yyyy-MM-dd').format(date);
      update();
    });
  }

  void selectType(BuildContext context) {
    if (typeList.isEmpty) {
      Fluttertoast.showToast(msg: 'Add a custom type');
      return;
    }
    Get.bottomSheet(Container(
      height: 400,
      child: SafeArea(
        child: ListView.builder(
            itemCount: typeList.length,
            itemBuilder: (_, index) {
              return <Widget>[
                ListTile(
                  title: Text(
                    typeList[index].name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    typeEntity = typeList[index];
                    Get.back();
                    update();
                  },
                ),
                Divider(
                  height: 5,
                  indent: 15,
                  endIndent: 15,
                  color: Colors.grey.withOpacity(0.3),
                )
              ].toColumn();
            }),
      ),
    ).decorated(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))));
  }

  void imageSelected() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        imageData = imageBytes;
        update();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Please try again with another picture');
      return;
    }
  }

  void save(BuildContext context) async {
    if (typeEntity == null) {
      Fluttertoast.showToast(msg: 'Please select a type');
      return;
    }
    if (imageData == null) {
      Fluttertoast.showToast(msg: 'Please select a picture');
      return;
    }
    if (dateTime == null) {
      Fluttertoast.showToast(msg: 'Please select a date');
      return;
    }
    if (name.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter the experiment name');
      return;
    }
    if (content.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter the experimental conclusion');
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    await dbExperiment.dbBase.insert('experiment', {
      'create_time': DateTime.now().toIso8601String(),
      'type': jsonEncode(typeEntity!.toJson()),
      'image_data': imageData!,
      'success': success.value ? 1 : 0,
      'name': name,
      'time': dateTime!.toIso8601String(),
      'content': content,
    });
    Fluttertoast.showToast(msg: 'Success');
    Get.back();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getTypes();
    super.onInit();
  }
}
