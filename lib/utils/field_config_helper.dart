import 'package:sqflite/sqflite.dart';
import '../models/field_config.dart';
import 'database_helper.dart';

class FieldConfigHelper {
  static const String table = 'field_configs';

  // デフォルト設定（fieldKey → FieldConfig）
  static final Map<int, FieldConfig> defaults = {
    1:  FieldConfig(fieldKey: 1,  step: 0.5,  dialMin: 100,  dialMax: 220,   defaultValue: 165),
    2:  FieldConfig(fieldKey: 2,  step: 0.5,  dialMin: 30,   dialMax: 200,   defaultValue: 60),
    3:  FieldConfig(fieldKey: 3,  step: 0.5,  dialMin: 50,   dialMax: 150,   defaultValue: 80),
    4:  FieldConfig(fieldKey: 4,  step: 0.1,  dialMin: 0.1,  dialMax: 2.0,   defaultValue: 1.0),
    5:  FieldConfig(fieldKey: 5,  step: 0.1,  dialMin: 0.1,  dialMax: 2.0,   defaultValue: 1.0),
    11: FieldConfig(fieldKey: 11, lower: 60,  upper: 89,   step: 1,    dialMin: 40,   dialMax: 150,   defaultValue: 75),
    12: FieldConfig(fieldKey: 12, lower: 90,  upper: 139,  step: 1,    dialMin: 60,   dialMax: 250,   defaultValue: 120),
    13: FieldConfig(fieldKey: 13, lower: 380, upper: 530,  step: 5,    dialMin: 200,  dialMax: 700,   defaultValue: 450),
    14: FieldConfig(fieldKey: 14, lower: 11,  upper: 17,   step: 0.1,  dialMin: 5,    dialMax: 25,    defaultValue: 13),
    15: FieldConfig(fieldKey: 15, lower: 10,  upper: 40,   step: 1,    dialMin: 0,    dialMax: 300,   defaultValue: 20),
    16: FieldConfig(fieldKey: 16, lower: 5,   upper: 45,   step: 1,    dialMin: 0,    dialMax: 300,   defaultValue: 20),
    17: FieldConfig(fieldKey: 17, lower: 10,  upper: 50,   step: 1,    dialMin: 0,    dialMax: 500,   defaultValue: 30),
    18: FieldConfig(fieldKey: 18, lower: 70,  upper: 139,  step: 1,    dialMin: 20,   dialMax: 300,   defaultValue: 100),
    19: FieldConfig(fieldKey: 19, lower: 40,  upper: 99,   step: 1,    dialMin: 10,   dialMax: 200,   defaultValue: 60),
    20: FieldConfig(fieldKey: 20,             upper: 149,  step: 5,    dialMin: 20,   dialMax: 1000,  defaultValue: 100),
    21: FieldConfig(fieldKey: 21,             upper: 99,   step: 1,    dialMin: 50,   dialMax: 600,   defaultValue: 90),
    22: FieldConfig(fieldKey: 22,             upper: 5.9,  step: 0.1,  dialMin: 3.0,  dialMax: 15.0,  defaultValue: 5.5),
    27: FieldConfig(fieldKey: 27, step: 0.1,  dialMin: 0.1,  dialMax: 2.0,   defaultValue: 1.0),
    28: FieldConfig(fieldKey: 28, step: 0.1,  dialMin: 0.1,  dialMax: 2.0,   defaultValue: 1.0),
    31: FieldConfig(fieldKey: 31, lower: 6.5, upper: 8.2,  step: 0.1,  dialMin: 3.0,  dialMax: 10.0,  defaultValue: 7.0),
    32: FieldConfig(fieldKey: 32, lower: 3.8, upper: 5.3,  step: 0.1,  dialMin: 2.0,  dialMax: 7.0,   defaultValue: 4.5),
    33: FieldConfig(fieldKey: 33,             upper: 1.2,  step: 0.1,  dialMin: 0.1,  dialMax: 10.0,  defaultValue: 0.8),
    34: FieldConfig(fieldKey: 34,             upper: 120,  step: 1,    dialMin: 0,    dialMax: 500,   defaultValue: 80),
    35: FieldConfig(fieldKey: 35,             upper: 219,  step: 1,    dialMin: 50,   dialMax: 400,   defaultValue: 180),
    36: FieldConfig(fieldKey: 36,             upper: 7.0,  step: 0.1,  dialMin: 0,    dialMax: 15.0,  defaultValue: 5.0),
    37: FieldConfig(fieldKey: 37, lower: 8.0, upper: 22.0, step: 0.5,  dialMin: 0,    dialMax: 100,   defaultValue: 15.0),
    38: FieldConfig(fieldKey: 38,             upper: 1.07, step: 0.01, dialMin: 0.1,  dialMax: 10.0,  defaultValue: 0.8),
    39: FieldConfig(fieldKey: 39,             upper: 125,  step: 1,    dialMin: 0,    dialMax: 500,   defaultValue: 80),
    40: FieldConfig(fieldKey: 40, lower: 3000,upper: 9000, step: 100,  dialMin: 1000, dialMax: 20000, defaultValue: 6000),
    41: FieldConfig(fieldKey: 41, lower: 35,  upper: 50,   step: 0.5,  dialMin: 20,   dialMax: 60,    defaultValue: 43),
    42: FieldConfig(fieldKey: 42, lower: 80,  upper: 100,  step: 0.5,  dialMin: 50,   dialMax: 120,   defaultValue: 90),
    43: FieldConfig(fieldKey: 43, lower: 27,  upper: 35,   step: 0.1,  dialMin: 15,   dialMax: 45,    defaultValue: 30),
    44: FieldConfig(fieldKey: 44, lower: 32,  upper: 36,   step: 0.1,  dialMin: 25,   dialMax: 40,    defaultValue: 33),
    45: FieldConfig(fieldKey: 45, lower: 60,  upper: 200,  step: 1,    dialMin: 10,   dialMax: 400,   defaultValue: 100),
    46: FieldConfig(fieldKey: 46, lower: 15,  upper: 40,   step: 0.5,  dialMin: 5,    dialMax: 100,   defaultValue: 25),
    49: FieldConfig(fieldKey: 49,             upper: 21,   step: 0.5,  dialMin: 5,    dialMax: 40,    defaultValue: 15),
    50: FieldConfig(fieldKey: 50,             upper: 21,   step: 0.5,  dialMin: 5,    dialMax: 40,    defaultValue: 15),
    51: FieldConfig(fieldKey: 51, step: 0.25, dialMin: -15, dialMax: 10,  defaultValue: -2),
    52: FieldConfig(fieldKey: 52, step: 0.25, dialMin: -15, dialMax: 10,  defaultValue: -2),
    53: FieldConfig(fieldKey: 53, step: 0.25, dialMin: -10, dialMax: 0,   defaultValue: -1),
    54: FieldConfig(fieldKey: 54, step: 0.25, dialMin: -10, dialMax: 0,   defaultValue: -1),
    55: FieldConfig(fieldKey: 55, step: 1,    dialMin: 0,   dialMax: 180, defaultValue: 90),
    56: FieldConfig(fieldKey: 56, step: 1,    dialMin: 0,   dialMax: 180, defaultValue: 90),
    57: FieldConfig(fieldKey: 57,             upper: 5.0,  step: 0.1,  dialMin: 0,    dialMax: 100,   defaultValue: 3.0),
    58: FieldConfig(fieldKey: 58,             upper: 10.0, step: 0.1,  dialMin: 0,    dialMax: 200,   defaultValue: 5.0),
    59: FieldConfig(fieldKey: 59,             upper: 4.0,  step: 0.1,  dialMin: 0,    dialMax: 100,   defaultValue: 2.0),
    60: FieldConfig(fieldKey: 60,             upper: 37.0, step: 0.5,  dialMin: 0,    dialMax: 1000,  defaultValue: 20.0),
    61: FieldConfig(fieldKey: 61,             upper: 35.0, step: 0.5,  dialMin: 0,    dialMax: 1000,  defaultValue: 20.0),
  };

  Future<Database> get _db async => DatabaseHelper().database;

  Future<Map<int, FieldConfig>> loadAll() async {
    final db = await _db;
    final rows = await db.query(table);
    final result = Map<int, FieldConfig>.from(defaults);
    for (final row in rows) {
      final config = FieldConfig.fromMap(row);
      result[config.fieldKey] = config;
    }
    return result;
  }

  Future<void> save(FieldConfig config) async {
    final db = await _db;
    final existing = await db.query(table,
        where: 'field_key = ?', whereArgs: [config.fieldKey]);
    if (existing.isNotEmpty) {
      final id = existing.first['id'] as int;
      await db.update(table, config.toMap(),
          where: 'id = ?', whereArgs: [id]);
    } else {
      await db.insert(table, config.toMap());
    }
  }
}
