import 'dart:convert';
import 'dart:typed_data';
import 'package:experiment/db_experiment/experiment_entity.dart';
import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBExperiment extends GetxService {
  late Database dbBase;
  final faker = Faker();

  Future<DBExperiment> init() async {
    await createExperimentDB();
    return this;
  }

  createExperimentDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'experiment.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await createExperimentTable(db);
      await createExperimentTypeTable(db);
      await _initData(db);
    });
  }

  createExperimentTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS experiment (id INTEGER PRIMARY KEY, create_time TEXT, type TEXT, image_data BLOB, success INTEGER, name TEXT, time TEXT, content TEXT)');
  }

  createExperimentTypeTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS experiment_type (id INTEGER PRIMARY KEY, create_time TEXT, name TEXT, is_hidden INTEGER)');
  }

  Future<Uint8List> loadImageBytes(String imagePath) async {
    ByteData data = await rootBundle.load(imagePath);
    Uint8List bytes = data.buffer.asUint8List();
    return bytes;
  }

  _initData(Database db) async {
    List<String> typeNames = ['Other experiment','Quantitative experiment', 'Structural Analysis experiment','Factorial experiment','Judgment experiment','Controlled experiment','Intermediate experiment'];
    List<ExperimentTypeEntity> types = [];
    for (int i = 0; i < typeNames.length; i++) {
      final id = await db.insert('experiment_type', {
        'create_time': DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
        'name': typeNames[i],
        'is_hidden': 0,
      });
      final type = ExperimentTypeEntity(
          id: id,
          name: typeNames[i],
          createTime: DateTime.now().subtract(const Duration(days: 5)),
          isHidden: 0);
      types.add(type);
    }
    for (int i = 0; i < 10; i++) {
      var imageBytes = await loadImageBytes('assets/image${i % 3}.webp');
      await db.insert('experiment', {
        'create_time':
            DateTime.now().subtract(Duration(hours: i*2)).toIso8601String(),
        'type': jsonEncode(types[i % 3].toJson()),
        'image_data': imageBytes,
        'success': faker.randomGenerator.integer(2),
        'name': faker.person.firstName(),
        'time': DateTime.now().subtract(Duration(hours: i*2)).toIso8601String(),
        'content': faker.lorem.sentence(),
      });
    }
  }

  deleteExperiment(ExperimentEntity entity) async {
    await dbBase.delete('experiment', where: 'id = ?', whereArgs: [entity.id]);
  }

  deleteExperimentType(ExperimentTypeEntity entity) async {
    await dbBase.update('experiment_type', {'is_hidden': 1},
        where: 'id = ?', whereArgs: [entity.id]);
  }

  cleanExperimentAllData() async {
    await dbBase.delete('experiment');
  }

  cleanExperimentTypeAllData() async {
    await dbBase.delete('experiment_type');
  }

  Future<List<ExperimentEntity>> getExperimentAllData() async {
    var result = await dbBase.query('experiment', orderBy: 'create_time DESC');
    return result.map((e) => ExperimentEntity.fromJson(e)).toList();
  }

  Future<List<ExperimentTypeEntity>> getExperimentTypeAllData() async {
    var result =
        await dbBase.query('experiment_type', orderBy: 'create_time DESC');
    return result.map((e) => ExperimentTypeEntity.fromJson(e)).toList();
  }
}
