import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../models/model.dart';

class CsvExporter {
  static Future<void> export(List<Model> modelList) async {
    final buffer = StringBuffer();

    // ヘッダー行
    buffer.writeln(
        '受診日,検査種別,身長,体重,腹囲,'
            '右視力(裸眼),左視力(裸眼),右視力(矯正),左視力(矯正),'
            '右聴力1000,左聴力1000,右聴力4000,左聴力4000,'
            '血圧(上),血圧(下),レントゲン,心電図,内科診察,'
            '総蛋白,アルブミン,総ビリルビン,GOT,GPT,ALP,γ-GTP,'
            '総コレステロール,LDL,HDL,中性脂肪,尿酸,'
            '尿素窒素,クレアチニン,アミラーゼ,'
            '空腹時血糖,HbA1c,'
            '白血球,赤血球,血色素,ヘマトクリット,MCV,MCH,MCHC,血清鉄,血小板,'
            '尿糖,尿蛋白,尿潜血,便潜血,メモ'
    );
    for (final model in modelList) {
      buffer.writeln(
          '${model.on_the_day_24},'
              '${model.priority},'
              '${model.height_1},'
              '${model.weight_2},'
              '${model.waist_3},'
              '${model.right_eye_4},'
              '${model.left_eye_5},'
              '${model.correctedEyesightRight_27},'
              '${model.correctedEyesightLeft_28},'
              '${model.hearing_right_1000_6},'
              '${model.hearing_left_1000_7},'
              '${model.hearing_right_4000_8},'
              '${model.hearing_left_4000_9},'
              '${model.high_blood_pressure_12},'
              '${model.low_blood_pressure_11},'
              '${model.x_ray_10},'
              '${model.ecg_23},'
              '${model.internal_47},'
              '${model.totalProtein_31},'
              '${model.albumin_32},'
              '${model.totalBilirubin_33},'
              '${model.got_15},'
              '${model.gpt_16},'
              '${model.alp_34},'
              '${model.gtp_17},'
              '${model.totalCholesterol_35},'
              '${model.ldl_18},'
              '${model.hdl_19},'
              '${model.neutral_fat_20},'
              '${model.uricAcid_36},'
              '${model.ureaNitrogen_37},'
              '${model.creatinine_38},'
              '${model.amylase_39},'
              '${model.blood_glucose_21},'
              '${model.hA1c_22},'
              '${model.whiteBloodCell_40},'
              '${model.red_blood_13},'
              '${model.hemoglobin_14},'
              '${model.hematocrit_41},'
              '${model.mcv_42},'
              '${model.mch_43},'
              '${model.mchc_44},'
              '${model.serumIron_45},'
              '${model.platelet_46},'
              '${model.sugar_26},'
              '${model.urine_25},'
              '${model.lateBlood_29},'
              '${model.bloodInTheStool_30},'
              '${model.memo_48}'
      );
    }
// ファイル保存
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/healthcare_export.csv';
    final file = File(path);
    await file.writeAsString(buffer.toString());

    // 共有
    await Share.shareXFiles(
      [XFile(path)],
      text: 'Healthcare Mania データエクスポート',
    );

  }
}