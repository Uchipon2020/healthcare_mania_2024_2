import 'package:flutter/material.dart';
import '../models/model.dart';
import 'graph/blood_Presser_graph.dart';
import 'graph/eight_graph.dart';

class ModelViewScreen2 extends StatefulWidget {
  final String appBarTitle;
  final Model model;
  final List<Model> modelList;

  const ModelViewScreen2(
      {super.key,
      required this.appBarTitle,
      required this.model,
      required this.modelList});

  @override
  State<ModelViewScreen2> createState() => _ModelViewScreen2State();
}

class _ModelViewScreen2State extends State<ModelViewScreen2> {
  static final _priorities = ['定期健康診断', '人間ドック', '独自検査'];
  late Map<int, String> modelViews;
  late Map<int, String> prevViews;

  String diffText(int key) {
    final current = double.tryParse(modelViews[key] ?? '');
    final previous = double.tryParse(prevViews[key] ?? '');
    if (current == null || previous == null) return '';
    final diff = current - previous;
    if (diff == 0) return '';
    final sign = diff > 0 ? '▲' : '▼';
    return ' $sign${diff.abs().toStringAsFixed(1)}';
  }

  // 基準値マップ（下限、上限）
  final Map<int, List<double?>> normalRanges = {
    1: [null, null], // 身長（基準値なし）
    2: [null, null], // 体重（基準値なし）
    11: [60.0, 89.0], // 血圧（下）
    12: [90.0, 139.0], // 血圧（上）
    13: [380.0, 530.0], // 赤血球
    14: [11.0, 17.0], // 血色素
    15: [10.0, 40.0], // GOT
    16: [5.0, 45.0], // GPT
    17: [10.0, 50.0], // γ-GTP
    18: [70.0, 139.0], // LDL
    19: [40.0, 99.0], // HDL
    20: [null, 149.0], // 中性脂肪
    21: [null, 99.0], // 血糖
    22: [null, 5.9], // HbA1c
    31: [6.5, 8.2], // 総蛋白
    32: [3.8, 5.3], // アルブミン
    33: [null, 1.2], // 総ビリルビン
    34: [null, 120.0], // ALP
    35: [null, 219.0], // 総コレステロール
    36: [null, 7.0], // 尿酸
    37: [8.0, 22.0], // 尿素窒素
    38: [null, 1.07], // クレアチニン
    39: [null, 125.0], // アミラーゼ
    40: [3000.0, 9000.0], // 白血球
    41: [35.0, 50.0], // ヘマトクリット
    42: [80.0, 100.0], // MCV
    43: [27.0, 35.0], // MCH
    44: [32.0, 36.0], // MCHC
    45: [60.0, 200.0], // 血清鉄
    46: [15.0, 40.0], // 血小板
  };

  @override
  void initState() {
    super.initState();
    // 現在のデータより古いレコードを日付順に並べて直前を取得
    final sorted = [...widget.modelList]
      ..sort((a, b) => a.on_the_day_24.compareTo(b.on_the_day_24));
    final currentIndex = sorted.indexWhere((m) => m.id == widget.model.id);
    final prev = currentIndex > 0 ? sorted[currentIndex - 1] : null;

    prevViews = {
      2: prev?.weight_2 ?? '',
      11: prev?.low_blood_pressure_11 ?? '',
      12: prev?.high_blood_pressure_12 ?? '',
      21: prev?.blood_glucose_21 ?? '',
      22: prev?.hA1c_22 ?? '',
      // 必要な項目を追加
    };
// 既存のmodelViews初期化...
    modelViews = {
      99: _priorities[widget.model.priority -1],
      1: widget.model.height_1,
      2: widget.model.weight_2,
      3: widget.model.waist_3,
      4: widget.model.right_eye_4,
      5: widget.model.left_eye_5,
      6: widget.model.hearing_right_1000_6,
      7: widget.model.hearing_left_1000_7,
      8: widget.model.hearing_right_4000_8,
      9: widget.model.hearing_left_4000_9,
      10: widget.model.x_ray_10,
      11: widget.model.low_blood_pressure_11,
      12: widget.model.high_blood_pressure_12,
      13: widget.model.red_blood_13,
      14: widget.model.hemoglobin_14,
      15: widget.model.got_15,
      16: widget.model.gpt_16,
      17: widget.model.gtp_17,
      18: widget.model.ldl_18,
      19: widget.model.hdl_19,
      20: widget.model.neutral_fat_20,
      21: widget.model.blood_glucose_21,
      22: widget.model.hA1c_22,
      23: widget.model.ecg_23,
      //24
      25: widget.model.urine_25,
      26: widget.model.sugar_26,
      27: widget.model.correctedEyesightRight_27,
      28: widget.model.correctedEyesightLeft_28,
      29: widget.model.lateBlood_29,
      30: widget.model.bloodInTheStool_30,
      31: widget.model.totalProtein_31,
      32: widget.model.albumin_32, //32
      33: widget.model.totalBilirubin_33,
      34: widget.model.alp_34,
      35: widget.model.totalCholesterol_35,
      36: widget.model.uricAcid_36,
      37: widget.model.ureaNitrogen_37,
      38: widget.model.creatinine_38,
      39: widget.model.amylase_39,
      40: widget.model.whiteBloodCell_40,
      41: widget.model.hematocrit_41,
      42: widget.model.mcv_42,
      43: widget.model.mch_43,
      44: widget.model.mchc_44,
      45: widget.model.serumIron_45,
      46: widget.model.platelet_46,
      47: widget.model.internal_47,
    };
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 99; i++) {
      if (modelViews[i] == '') {
        modelViews[i] = ' -- ';
      }
    }
    return Scaffold(
      appBar: AppBar(
        title:
            Text('${widget.appBarTitle} : ${widget.model.on_the_day_24} 実施分'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          Text('検査種別: ${modelViews[99]!}'),
          Card(
            elevation: 0.0,
            child: Text(
              '身長: ${modelViews[1]!} cm',
              style: TextStyle(
                fontWeight: weightCheck(1),
              ),
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          WeightGraph(modelList: widget.modelList)));
                },
                child: Card(
                  elevation: 0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '体重: ${modelViews[2]!} kg${diffText(2)}',
                        style: TextStyle(
                          fontWeight: weightCheck(2),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: Icon(Icons.auto_graph_sharp),
              ),
            ],
          ),
          Card(
            elevation: 0.0,
            child: Text(
              '腹囲: ${modelViews[3]!} cm',
              style: TextStyle(
                fontWeight: weightCheck(3),
              ),
            ),
          ),
          Card(
            elevation: 0.0,
            child: Column(children: [
              Row(
                children: [
                  Text(
                    '右目（裸眼）：${modelViews[4]!}',
                    style: TextStyle(
                      fontWeight: weightCheck(4),
                    ),
                  ),
                  Text(
                    '/ 左目（裸眼）：${modelViews[5]!}',
                    style: TextStyle(
                      fontWeight: weightCheck(5),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '右目（矯正）：${modelViews[27]!}',
                    style: TextStyle(
                      fontWeight: weightCheck(27),
                    ),
                  ),
                  Text(
                    '/ 左目（矯正）：${modelViews[28]!}',
                    style: TextStyle(
                      fontWeight: weightCheck(28),
                    ),
                  ),
                ],
              ),
            ]),
          ),
          Card(
            elevation: 0.0,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '右聴力 1000Mz：${modelViews[6]!}',
                      style: TextStyle(
                        fontWeight: weightCheck(6),
                      ),
                    ),
                    Text(
                      '/ 左聴力 1000Mz：${modelViews[7]!}',
                      style: TextStyle(
                        fontWeight: weightCheck(7),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '右聴力 4000Mz：${modelViews[8]!}',
                      style: TextStyle(
                        fontWeight: weightCheck(8),
                      ),
                    ),
                    Text(
                      '/ 左聴力 4000Mz：${modelViews[9]!}',
                      style: TextStyle(
                        fontWeight: weightCheck(9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          BloodPressureGraph(modelList: widget.modelList)));
                },
                child: Card(
                  elevation: 0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '血圧（上・収縮機）: ${modelViews[12]!} mmHg${diffText(12)}',
                        style: TextStyle(
                          fontWeight: weightCheck(12),
                          color: valueColor(12),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '血圧（下・拡張期）: ${modelViews[11]!} mmHg${diffText(11)}',
                        style: TextStyle(
                          fontWeight: weightCheck(11),
                          color: valueColor(11),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: Icon(Icons.auto_graph),
              ),
            ],
          ),
          Card(
            elevation: 0.0,
            child: Text(
              'X-線検査：${modelViews[10]!}',
              style: TextStyle(
                fontWeight: weightCheck(10),
              ),
            ),
          ),
          Card(
            elevation: 0.0,
            child: Text(
              '心電図検査所見：${modelViews[23]!}',
              style: TextStyle(
                fontWeight: weightCheck(23),
              ),
            ),
          ),
          Card(
            elevation: 0.0,
            child: Text(
              '内科診察所見：${modelViews[47]!}',
              style: TextStyle(
                fontWeight: weightCheck(47),
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 0,
            indent: 20,
            endIndent: 0,
          ),
          const Text(
            '血液検査',
            style: TextStyle(color: Colors.red),
          ),
          Card(
            elevation: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '血清蛋白',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '総蛋白：${modelViews[31]!}g/dL',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: weightCheck(31),
                    color: valueColor(31),
                  ),
                ),
                Text(
                  'アルブミン：${modelViews[32]!} g/dL',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: weightCheck(32),
                    color: valueColor(32),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 3.0,
          ),
          Card(
            elevation: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '肝機能',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '総ビリルビン：${modelViews[33]!} mg/dL',
                  style: TextStyle(
                    fontWeight: weightCheck(33),
                    color: valueColor(33),
                  ),
                ),
                Text(
                  'GOT（ALT)：${modelViews[15]!} U/L',
                  style: TextStyle(
                    fontWeight: weightCheck(15),
                    color: valueColor(15),
                  ),
                ),
                Text(
                  'GPT（AST)：${modelViews[16]!} U/L',
                  style: TextStyle(
                    fontWeight: weightCheck(16),
                    color: valueColor(16),
                  ),
                ),
                Text(
                  'ALP：${modelViews[34]!} U/L',
                  style: TextStyle(
                    fontWeight: weightCheck(34),
                    color: valueColor(34),
                  ),
                ),
                Text(
                  'γ-GTP：${modelViews[17]!} U/L',
                  style: TextStyle(
                    fontWeight: weightCheck(17),
                    color: valueColor(17),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 3.0),
          Card(
            elevation: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '脂質',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  '総コレステロール：${modelViews[35]!} mg/dL',
                  style: TextStyle(
                    fontWeight: weightCheck(35),
                    color: valueColor(35),
                  ),
                ),
                Text(
                  'ＬＤＬ: ${modelViews[18]!} mg/dL',
                  style: TextStyle(
                    fontWeight: weightCheck(18),
                    color: valueColor(18),
                  ),
                ),
                Text(
                  'ＨＤＬ: ${modelViews[19]!} mg/dL',
                  style: TextStyle(
                    fontWeight: weightCheck(19),
                    color: valueColor(19),
                  ),
                ),
                Text(
                  '中性脂肪：${modelViews[20]!} mg/dL',
                  style: TextStyle(
                    fontWeight: weightCheck(20),
                    color: valueColor(20),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 3.0),
          Card(
            elevation: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '尿酸',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '尿酸：${modelViews[36]!}',
                  style: TextStyle(
                    fontWeight: weightCheck(36),
                    color: valueColor(36),
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          const SizedBox(height: 3.0),
          Card(
            elevation: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '腎機能',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '尿素窒素：${modelViews[37]!} mg/dL',
                  style: TextStyle(
                    fontWeight: weightCheck(37),
                    color: valueColor(37),
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '尿糖：${modelViews[26]!}',
                  style: TextStyle(
                    fontWeight: weightCheck(26),
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '尿蛋白：${modelViews[25]!}',
                  style: TextStyle(
                    fontWeight: weightCheck(25),
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'クレアチニン：${modelViews[38]!} mg/dL',
                  style: TextStyle(
                    fontWeight: weightCheck(38),
                    color: valueColor(38),
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '尿潜血：${modelViews[29]!}',
                  style: TextStyle(
                    fontWeight: weightCheck(29),
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          const SizedBox(height: 3.0),
          Card(
            elevation: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('アミラーゼ',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.left),
                Text('アミラーゼ：${modelViews[39]!} U/L',
                    style: TextStyle(
                      fontWeight: weightCheck(39),
                      color: valueColor(39),
                    ),
                    textAlign: TextAlign.left),
              ],
            ),
          ),
          const SizedBox(height: 3.0),
          Card(
            elevation: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '糖代謝',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '空腹時血糖：${modelViews[21]!} mg/dL${diffText(21)}',
                  style: TextStyle(
                    fontWeight: weightCheck(21),
                    color: valueColor(21),
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'HbA1c：${modelViews[22]!} %${diffText(22)}',
                  style: TextStyle(
                    fontWeight: weightCheck(22),
                    color: valueColor(22),
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          const SizedBox(height: 3.0),
          Card(
            elevation: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '白血球数',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '白血球数: ${modelViews[40]!} /μL',
                  style: TextStyle(
                    fontWeight: weightCheck(40),
                    color: valueColor(40),
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          const SizedBox(height: 3.0),
          Card(
            elevation: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '貧血',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '赤血球数: ${modelViews[13]!} 万/μL',
                  style: TextStyle(
                    fontWeight: weightCheck(13),
                    color: valueColor(13),
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '血色素量：${modelViews[14]!} g/dL',
                  style: TextStyle(
                    fontWeight: weightCheck(14),
                    color: valueColor(14),
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'ヘマトクリット：${modelViews[41]!} %',
                  style: TextStyle(
                    fontWeight: weightCheck(41),
                    color: valueColor(41),
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'ＭＣＶ：${modelViews[42]!} fL',
                  style: TextStyle(
                    fontWeight: weightCheck(42),
                    color: valueColor(42),
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'ＭＣＨ：${modelViews[43]!} fL',
                  style: TextStyle(
                    fontWeight: weightCheck(43),
                    color: valueColor(43),
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'ＭＣＨＣ：${modelViews[44]!} %',
                  style: TextStyle(
                    fontWeight: weightCheck(44),
                    color: valueColor(44),
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '血清鉄：${modelViews[45]!} μg/dL',
                  style: TextStyle(
                    fontWeight: weightCheck(45),
                    color: valueColor(45),
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          const SizedBox(height: 3.0),
          Card(
            elevation: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '血小板',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '血小板：${modelViews[46]!}  万/μL',
                  style: TextStyle(
                    fontWeight: weightCheck(46),
                    color: valueColor(46),
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 0,
            indent: 20,
            endIndent: 0,
          ),
          const SizedBox(
            height: 3.0,
          ),
          Card(
            elevation: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '便潜血',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '便潜血：${modelViews[30]!},',
                  style: TextStyle(
                    fontWeight: weightCheck(30),
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  FontWeight weightCheck(int inside) {
    return modelViews[inside] == ' -- ' ? FontWeight.normal : FontWeight.bold;
  }
  Color valueColor(int key) {
    if (modelViews[key] == ' -- ') return Colors.black;
    final value = double.tryParse(modelViews[key]!);
    if (value == null) return Colors.black;
    final range = normalRanges[key];
    if (range == null) return Colors.black;
    final lower = range[0];
    final upper = range[1];
    if (lower != null && value < lower) return Colors.red;
    if (upper != null && value > upper) return Colors.red;
    return Colors.black;
  }
}
