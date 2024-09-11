import 'dart:convert';
import 'dart:typed_data';
import 'package:intl/intl.dart';

class ExperimentEntity {
  int id;
  DateTime createTime;
  ExperimentTypeEntity type;
  Uint8List imageData;
  int success;
  String name;
  DateTime time;
  String content;

  ExperimentEntity({
    required this.id,
    required this.createTime,
    required this.type,
    required this.imageData,
    required this.success,
    required this.name,
    required this.time,
    required this.content,
  });

  factory ExperimentEntity.fromJson(Map<String, dynamic> json) {
    return ExperimentEntity(
      id: json['id'],
      createTime: DateTime.parse(json['create_time']),
      type: ExperimentTypeEntity.fromJson(jsonDecode(json['type'])),
      imageData: json['image_data'],
      success: json['success'],
      name: json['name'],
      time: DateTime.parse(json['time']),
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'create_time': createTime.toIso8601String(),
      'type': jsonEncode(type.toJson()),
      'image_data': imageData,
      'success': success,
      'name': name,
      'time': time.toIso8601String(),
      'content': content,
    };
  }

  String get timeString {
    return DateFormat('yyyy.MM.dd').format(time);
  }
}

class ExperimentTypeEntity {
  int id;
  String name;
  DateTime createTime;
  int isHidden;
  List<ExperimentEntity>? list;

  ExperimentTypeEntity({
    required this.id,
    required this.name,
    required this.createTime,
    required this.isHidden,
  });

  factory ExperimentTypeEntity.fromJson(Map<String, dynamic> json) {
    return ExperimentTypeEntity(
      id: json['id'],
      name: json['name'],
      createTime: DateTime.parse(json['create_time']),
      isHidden: json['is_hidden'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'create_time': createTime.toIso8601String(),
      'is_hidden': isHidden,
    };
  }


}
