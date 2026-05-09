import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/model.dart';

//データベースとのやり取りを、別クラスにした
class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  String modelTable = 'model_table';
  String colId = 'id';
  String col0101 = 'height';
  String col0102 = 'weight';
  String col0103 = 'right_eye';
  String col0104 = 'left_eye';
  String col0105 = 'hearing_right_1000';
  String col0106 = 'hearing_left_1000';
  String col0107 = 'hearing_right_4000';
  String col0108 = 'hearing_left_4000';
  String colXRay = 'x_ray';
  String colBpLow = 'low_blood_pressure';
  String colBpHeight = 'high_blood_pressure';
  String colRedBlood = 'red_blood';
  String colHemoglobin = 'hemoglobin';
  String colGot = 'got';
  String colGpt = 'gpt';
  String colGtp = 'gtp';
  String colLdl = 'ldl';
  String colHdl = 'hdl';
  String colNeutralFat = 'neutral_fat';
  String colBloodGlucose = 'blood_glucose';
  String colHA1c = 'hA1c';
  String colSugar = 'sugar';
  String colUrine = 'urine';
  String colEcg = 'ecg';
  String colOnTheDay = 'on_the_day';
  String colPriority = 'priority';
  String colDate = 'date';

  //Ver2追加
  String colWaist = 'waist';
  String colCorrectedEyeR = 'correctedEyesight_right'; //矯正視力右
  String colCorrectedEyeL = 'correctedEyesight_left'; //矯正視力左
  String colLatenBlood = 'latenBlood'; //潜血
  String colBloodInTheStool = 'bloodInTheStool'; //便潜血
  String colTotalProtein = 'totalProtein'; //総蛋白
  String colAlbumin = 'albumin'; //アルブミ
  String colTotalBilirubin = 'totalBilirubin'; //総ビリルビン
  String colAlp = 'alp'; //ALP
  String colTotalCholesterol = 'totalCholesterol'; //総コレステロール
  String colUricAcid = 'uricAcid'; //尿酸
  String colReaNitrogen = 'ureaNitrogen'; //尿素窒素
  String colCreatinine = 'creatinine'; //クレアチニン
  String colAmylase = 'amylase'; //アミラーゼ
  String colWhiteBloodCell = 'whiteBloodCell'; //白血球数
  String colHematocrit = 'hematocrit';
  String colMcv = 'mcv';
  String colMch = 'mch';
  String colMchc = 'mchc';
  String colSerumIron = 'serumIron';
  String colPlatelet = 'platelet';
  String colInternal = 'internal';
  String colMemo = 'memo';

  //Ver3追加
  String colEyePressureRight = 'eye_pressure_right';
  String colEyePressureLeft = 'eye_pressure_left';
  String colContactRight = 'contact_right';
  String colContactLeft = 'contact_left';
  String colAstigRight = 'astig_right';
  String colAstigLeft = 'astig_left';
  String colAxisRight = 'axis_right';
  String colAxisLeft = 'axis_left';
  String colCea = 'cea';
  String colAfp = 'afp';
  String colPsa = 'psa';
  String colCa19_9 = 'ca19_9';
  String colCa125 = 'ca125';

  DatabaseHelper._createInstance(); //
  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/models.db';
    var modelsDatabase = await openDatabase(path,
        version: 5, onCreate: _createDb, onUpgrade: _upgradeDB);
    return modelsDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('CREATE TABLE $modelTable('
        ' $colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        ' $col0101 TEXT, $col0102 TEXT,'
        ' $col0103 TEXT, $col0104 TEXT,'
        ' $col0105 TEXT, $col0106 TEXT,'
        ' $col0107 TEXT, $col0108 TEXT,'
        ' $colXRay TEXT, '
        ' $colBpLow TEXT, $colBpHeight TEXT,'
        ' $colRedBlood TEXT, $colHemoglobin TEXT,'
        ' $colGot TEXT, $colGpt TEXT, $colGtp TEXT, $colLdl TEXT, $colHdl TEXT, $colNeutralFat TEXT, '
        ' $colBloodGlucose TEXT, $colHA1c TEXT, $colUrine TEXT, $colSugar TEXT, $colEcg TEXT, '
        ' $colOnTheDay TEXT, $colPriority INTEGER, $colDate TEXT, $colWaist TEXT, $colCorrectedEyeR TEXT,'
        ' $colCorrectedEyeL TEXT, $colLatenBlood TEXT, $colBloodInTheStool TEXT, $colTotalProtein TEXT,'
        ' $colAlbumin TEXT, $colTotalBilirubin TEXT, $colAlp TEXT, $colTotalCholesterol TEXT,' //
        ' $colUricAcid TEXT, $colReaNitrogen TEXT, $colCreatinine TEXT, $colAmylase TEXT,'
        ' $colWhiteBloodCell TEXT, $colHematocrit TEXT, $colMcv TEXT, $colMch TEXT, $colMchc TEXT,'
        ' $colSerumIron TEXT, $colPlatelet TEXT, $colInternal TEXT,'
        ' $colMemo TEXT,'
        ' $colEyePressureRight TEXT, $colEyePressureLeft TEXT,'
        ' $colContactRight TEXT, $colContactLeft TEXT,'
        ' $colAstigRight TEXT, $colAstigLeft TEXT,'
        ' $colAxisRight TEXT, $colAxisLeft TEXT,'
        ' $colCea TEXT, $colAfp TEXT, $colPsa TEXT,'
        ' $colCa19_9 TEXT, $colCa125 TEXT)');
  }

  void _upgradeDB(Database db, int oldVersion, int newVersion) async {
    final alters = [
      'ALTER TABLE $modelTable ADD COLUMN $colWaist TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colCorrectedEyeR TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colCorrectedEyeL TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colLatenBlood TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colBloodInTheStool TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colTotalProtein TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colAlbumin TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colTotalBilirubin TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colAlp TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colTotalCholesterol TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colUricAcid TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colReaNitrogen TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colCreatinine TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colAmylase TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colWhiteBloodCell TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colHematocrit TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colMcv TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colMch TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colMchc TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colSerumIron TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colPlatelet TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colInternal TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colMemo TEXT',
      ////////
      'ALTER TABLE $modelTable ADD COLUMN $colEyePressureRight TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colEyePressureLeft TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colContactRight TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colContactLeft TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colAstigRight TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colAstigLeft TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colAxisRight TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colAxisLeft TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colCea TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colAfp TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colPsa TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colCa19_9 TEXT',
      'ALTER TABLE $modelTable ADD COLUMN $colCa125 TEXT',
    ];
    for (final sql in alters) {
      try {
        await db.execute(sql);
      } catch (e) {
        if (kDebugMode) print('Skip: $sql - $e');
      }
    }
  }

  Future<List<Map<String, dynamic>>> getModelMapList() async {
    Database db = await database;
    var result = await db.query(modelTable, orderBy: '$colPriority ASC');
    return result;
  }

  Future<int> insertModel(Model models) async {
    Database db = await database;
    var result = await db.insert(modelTable, models.toMap());
    return result;
  }

  Future<int> updateModel(Model model) async {
    var db = await database;
    var result = await db.update(modelTable, model.toMap(),
        where: '$colId = ?', whereArgs: [model.id]);
    return result;
  }

  Future<int> deleteModel(int id) async {
    var db = await database;
    int result =
        await db.rawDelete('DELETE FROM $modelTable WHERE $colId = $id');
    return result;
  }

  Future<int?> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $modelTable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Model>> getModelList() async {
    var modelMapList = await getModelMapList(); // Get 'Map List' from database
    int count =
        modelMapList.length; // Count the number of map entries in db table
    List<Model> modelList = <Model>[];
    for (int i = 0; i < count; i++) {
      modelList.add(Model.fromMapObject(modelMapList[i]));
    }
    return modelList;
  }
}
