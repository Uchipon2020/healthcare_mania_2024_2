import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/model.dart';
import '../models/field_config.dart';
import '../utils/database_helper.dart';
import '../utils/field_config_helper.dart';
import '../widgets/jog_dial_field.dart';

class ModelDetailScreen extends StatefulWidget {
  final String appBarTitle;
  final Model model;
  const ModelDetailScreen(
      {Key? key, required this.appBarTitle, required this.model})
      : super(key: key);
  @override
  State<ModelDetailScreen> createState() => _ModelDetailScreenState();
}

class _ModelDetailScreenState extends State<ModelDetailScreen> {
  static final _priorities = ['定期健康診断', '人間ドック', '独自検査'];
  DatabaseHelper helper = DatabaseHelper();
  final _configHelper = FieldConfigHelper();
  Map<int, FieldConfig> _configs = Map.from(FieldConfigHelper.defaults);

  dynamic dateNow;
  dynamic dateFormat;

  // Controllers
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController rEyeController = TextEditingController();
  TextEditingController lEyeController = TextEditingController();
  TextEditingController lBpController = TextEditingController();
  TextEditingController hBpController = TextEditingController();
  TextEditingController onTheDayController = TextEditingController();
  TextEditingController hR1000Controller = TextEditingController();
  TextEditingController hL1000Controller = TextEditingController();
  TextEditingController hR4000Controller = TextEditingController();
  TextEditingController hL4000Controller = TextEditingController();
  TextEditingController xRayController = TextEditingController();
  TextEditingController rBController = TextEditingController();
  TextEditingController hEmoController = TextEditingController();
  TextEditingController gOtController = TextEditingController();
  TextEditingController gPtController = TextEditingController();
  TextEditingController gTpController = TextEditingController();
  TextEditingController lDlController = TextEditingController();
  TextEditingController hDlController = TextEditingController();
  TextEditingController nFatController = TextEditingController();
  TextEditingController bGluController = TextEditingController();
  TextEditingController hA1cController = TextEditingController();
  TextEditingController eCgController = TextEditingController();
  TextEditingController sugarController = TextEditingController();
  TextEditingController urineController = TextEditingController();
  final waistController = TextEditingController();
  final correctEyeRController = TextEditingController();
  final correctEyeLController = TextEditingController();
  final latentBloodController = TextEditingController();
  final bloodInTheStoolController = TextEditingController();
  final totalProteinController = TextEditingController();
  final albuminController = TextEditingController();
  final totalBilirubinController = TextEditingController();
  final alpController = TextEditingController();
  final totalCholesterolController = TextEditingController();
  final uricAcidController = TextEditingController();
  final ureaNitrogenController = TextEditingController();
  final creatinineController = TextEditingController();
  final amylaseController = TextEditingController();
  final whiteBloodCellController = TextEditingController();
  final hematocritController = TextEditingController();
  final mcvController = TextEditingController();
  final mchController = TextEditingController();
  final mchcController = TextEditingController();
  final serumIronController = TextEditingController();
  final plateletController = TextEditingController();
  final internalController = TextEditingController();
  final memoController = TextEditingController();
  final eyePressureRController = TextEditingController();
  final eyePressureLController = TextEditingController();
  final contactRController = TextEditingController();
  final contactLController = TextEditingController();
  final astigRController = TextEditingController();
  final astigLController = TextEditingController();
  final axisRController = TextEditingController();
  final axisLController = TextEditingController();
  final ceaController = TextEditingController();
  final afpController = TextEditingController();
  final psaController = TextEditingController();
  final ca19_9Controller = TextEditingController();
  final ca125Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateFormat = DateTime.now();
    dateNow = DateFormat("yyyy年MM月dd日").format(dateFormat);

    heightController.text = widget.model.height_1;
    weightController.text = widget.model.weight_2;
    rEyeController.text = widget.model.right_eye_4;
    lEyeController.text = widget.model.left_eye_5;
    lBpController.text = widget.model.low_blood_pressure_11;
    hBpController.text = widget.model.high_blood_pressure_12;
    onTheDayController.text = widget.model.on_the_day_24;
    hR1000Controller.text = widget.model.hearing_right_1000_6;
    hL1000Controller.text = widget.model.hearing_left_1000_7;
    hR4000Controller.text = widget.model.hearing_right_4000_8;
    hL4000Controller.text = widget.model.hearing_left_4000_9;
    xRayController.text = widget.model.x_ray_10;
    rBController.text = widget.model.red_blood_13;
    hEmoController.text = widget.model.hemoglobin_14;
    gOtController.text = widget.model.got_15;
    gPtController.text = widget.model.gpt_16;
    gTpController.text = widget.model.gtp_17;
    lDlController.text = widget.model.ldl_18;
    hDlController.text = widget.model.hdl_19;
    nFatController.text = widget.model.neutral_fat_20;
    bGluController.text = widget.model.blood_glucose_21;
    hA1cController.text = widget.model.hA1c_22;
    eCgController.text = widget.model.ecg_23;
    sugarController.text = widget.model.sugar_26;
    urineController.text = widget.model.urine_25;
    waistController.text = widget.model.waist_3;
    correctEyeRController.text = widget.model.correctedEyesightRight_27;
    correctEyeLController.text = widget.model.correctedEyesightLeft_28;
    latentBloodController.text = widget.model.lateBlood_29;
    bloodInTheStoolController.text = widget.model.bloodInTheStool_30;
    totalProteinController.text = widget.model.totalProtein_31;
    albuminController.text = widget.model.albumin_32;
    totalBilirubinController.text = widget.model.totalBilirubin_33;
    alpController.text = widget.model.alp_34;
    totalCholesterolController.text = widget.model.totalCholesterol_35;
    uricAcidController.text = widget.model.uricAcid_36;
    ureaNitrogenController.text = widget.model.ureaNitrogen_37;
    creatinineController.text = widget.model.creatinine_38;
    amylaseController.text = widget.model.amylase_39;
    whiteBloodCellController.text = widget.model.whiteBloodCell_40;
    hematocritController.text = widget.model.hematocrit_41;
    mcvController.text = widget.model.mcv_42;
    mchController.text = widget.model.mch_43;
    mchcController.text = widget.model.mchc_44;
    serumIronController.text = widget.model.serumIron_45;
    plateletController.text = widget.model.platelet_46;
    internalController.text = widget.model.internal_47;
    memoController.text = widget.model.memo_48;
    eyePressureRController.text = widget.model.eyePressureRight_49;
    eyePressureLController.text = widget.model.eyePressureLeft_50;
    contactRController.text = widget.model.contactRight_51;
    contactLController.text = widget.model.contactLeft_52;
    astigRController.text = widget.model.astigRight_53;
    astigLController.text = widget.model.astigLeft_54;
    axisRController.text = widget.model.axisRight_55;
    axisLController.text = widget.model.axisLeft_56;
    ceaController.text = widget.model.cea_57;
    afpController.text = widget.model.afp_58;
    psaController.text = widget.model.psa_59;
    ca19_9Controller.text = widget.model.ca19_9_60;
    ca125Controller.text = widget.model.ca125_61;

    _loadConfigs();
  }

  Future<void> _loadConfigs() async {
    final configs = await _configHelper.loadAll();
    if (mounted) setState(() => _configs = configs);
  }

  Future<void> _saveConfig(FieldConfig config) async {
    await _configHelper.save(config);
    final configs = await _configHelper.loadAll();
    if (mounted) setState(() => _configs = configs);
  }

  FieldConfig _cfg(int key) =>
      _configs[key] ?? FieldConfigHelper.defaults[key]!;

  double _selectedValue = 1.0;
  final double _minValue = 1.0;
  final double _maxValue = 10.0;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            // 検査種別
            ListTile(
              title: DropdownButton(
                items: _priorities.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0),
                      child: Text(item,
                          style: const TextStyle(fontSize: 20.5)),
                    ),
                  );
                }).toList(),
                style: textStyle,
                value: getPriorityAsString(widget.model.priority),
                onChanged: (String? value) {
                  setState(() => updatePriorityAsInt(value!));
                },
              ),
            ),
            // 受診日
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
              child: TextField(
                focusNode: AlwaysDisabledFocusNode(),
                controller: onTheDayController,
                style: textStyle,
                textAlign: TextAlign.right,
                onTap: () => _selectDate(context),
                onChanged: (value) {
                  setState(() => onTheDayController.text = dateNow);
                },
                decoration: InputDecoration(
                  labelText: '受診日',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  icon: const Icon(Icons.calendar_today_outlined),
                ),
              ),
            ),
            // 身長
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: JogDialField(
                label: '身長',
                unit: 'cm',
                icon: Icons.accessibility,
                controller: heightController,
                config: _cfg(1),
                onValueChanged: updateHeight,
                onConfigChanged: _saveConfig,
              ),
            ),
            // 体重
            Padding(
              padding: const EdgeInsets.only(top: 2.5, bottom: 10.0),
              child: JogDialField(
                label: '体重',
                unit: 'kg',
                icon: Icons.accessibility,
                controller: weightController,
                config: _cfg(2),
                onValueChanged: updateWeight,
                onConfigChanged: _saveConfig,
              ),
            ),
            // 腹囲
            Padding(
              padding: const EdgeInsets.only(top: 2.5, bottom: 10.0),
              child: JogDialField(
                label: '腹囲',
                unit: 'cm',
                icon: Icons.accessibility,
                controller: waistController,
                config: _cfg(3),
                onValueChanged: updateWaist,
                onConfigChanged: _saveConfig,
              ),
            ),
            // 視力（裸眼）
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: JogDialField(
                      label: '右視力',
                      icon: Icons.remove_red_eye,
                      controller: rEyeController,
                      config: _cfg(4),
                      onValueChanged: updateREye,
                      onConfigChanged: _saveConfig,
                    ),
                  ),
                  Container(width: 5.0),
                  Expanded(
                    child: JogDialField(
                      label: '左視力',
                      icon: Icons.remove_red_eye,
                      controller: lEyeController,
                      config: _cfg(5),
                      onValueChanged: updateLEye,
                      onConfigChanged: _saveConfig,
                    ),
                  ),
                ],
              ),
            ),
            // 矯正視力
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: JogDialField(
                      label: '矯正(右)',
                      icon: Icons.remove_red_eye_outlined,
                      controller: correctEyeRController,
                      config: _cfg(27),
                      onValueChanged: updateCorrectER,
                      onConfigChanged: _saveConfig,
                    ),
                  ),
                  Container(width: 5.0),
                  Expanded(
                    child: JogDialField(
                      label: '矯正(左)',
                      icon: Icons.remove_red_eye_outlined,
                      controller: correctEyeLController,
                      config: _cfg(28),
                      onValueChanged: updateCorrectEL,
                      onConfigChanged: _saveConfig,
                    ),
                  ),
                ],
              ),
            ),
            // 眼科セクション
            Row(children: [
              Expanded(child: Divider(color: Colors.blue)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('眼科',
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold)),
              ),
              Expanded(child: Divider(color: Colors.blue)),
            ]),
            ExpansionTile(
              title: const Text('眼圧'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Expanded(
                      child: JogDialField(
                        label: '右眼圧',
                        unit: 'mmHg',
                        icon: Icons.remove_red_eye,
                        controller: eyePressureRController,
                        config: _cfg(49),
                        onValueChanged: updateEyePressureR,
                        onConfigChanged: _saveConfig,
                      ),
                    ),
                    Container(width: 5.0),
                    Expanded(
                      child: JogDialField(
                        label: '左眼圧',
                        unit: 'mmHg',
                        icon: Icons.remove_red_eye,
                        controller: eyePressureLController,
                        config: _cfg(50),
                        onValueChanged: updateEyePressureL,
                        onConfigChanged: _saveConfig,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('コンタクト・乱視・軸度'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Expanded(
                      child: JogDialField(
                        label: 'コンタクト(右)',
                        icon: Icons.remove_red_eye_outlined,
                        controller: contactRController,
                        config: _cfg(51),
                        onValueChanged: updateContactR,
                        onConfigChanged: _saveConfig,
                      ),
                    ),
                    Container(width: 5.0),
                    Expanded(
                      child: JogDialField(
                        label: 'コンタクト(左)',
                        icon: Icons.remove_red_eye_outlined,
                        controller: contactLController,
                        config: _cfg(52),
                        onValueChanged: updateContactL,
                        onConfigChanged: _saveConfig,
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Expanded(
                      child: JogDialField(
                        label: '乱視(右)',
                        icon: Icons.remove_red_eye_outlined,
                        controller: astigRController,
                        config: _cfg(53),
                        onValueChanged: updateAstigR,
                        onConfigChanged: _saveConfig,
                      ),
                    ),
                    Container(width: 5.0),
                    Expanded(
                      child: JogDialField(
                        label: '乱視(左)',
                        icon: Icons.remove_red_eye_outlined,
                        controller: astigLController,
                        config: _cfg(54),
                        onValueChanged: updateAstigL,
                        onConfigChanged: _saveConfig,
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Expanded(
                      child: JogDialField(
                        label: '軸度(右)',
                        unit: '°',
                        icon: Icons.remove_red_eye_outlined,
                        controller: axisRController,
                        config: _cfg(55),
                        onValueChanged: updateAxisR,
                        onConfigChanged: _saveConfig,
                      ),
                    ),
                    Container(width: 5.0),
                    Expanded(
                      child: JogDialField(
                        label: '軸度(左)',
                        unit: '°',
                        icon: Icons.remove_red_eye_outlined,
                        controller: axisLController,
                        config: _cfg(56),
                        onValueChanged: updateAxisL,
                        onConfigChanged: _saveConfig,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            // 聴力1000Hz（テキスト）
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 2.5),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    controller: hR1000Controller,
                    style: textStyle,
                    onChanged: (value) => updateHearing_r_1000(),
                    decoration: InputDecoration(
                      labelText: '右聴力1000',
                      labelStyle: textStyle,
                      icon: const Icon(Icons.hearing),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                Container(width: 5.0),
                Expanded(
                  child: TextField(
                    controller: hL1000Controller,
                    style: textStyle,
                    onChanged: (value) => updateHearing_l_1000(),
                    decoration: InputDecoration(
                      labelText: '左聴力1000',
                      labelStyle: textStyle,
                      icon: const Icon(Icons.hearing),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
              ]),
            ),
            // 聴力4000Hz（テキスト）
            Padding(
              padding: const EdgeInsets.only(top: 2.5, bottom: 10.0),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    controller: hR4000Controller,
                    style: textStyle,
                    onChanged: (value) => updateHearing_r_4000(),
                    decoration: InputDecoration(
                      labelText: '右聴力4000',
                      labelStyle: textStyle,
                      icon: const Icon(Icons.hearing),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                Container(width: 5.0),
                Expanded(
                  child: TextField(
                    controller: hL4000Controller,
                    style: textStyle,
                    onChanged: (value) => updateHearing_l_4000(),
                    decoration: InputDecoration(
                      labelText: '左聴力4000',
                      labelStyle: textStyle,
                      icon: const Icon(Icons.hearing),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
              ]),
            ),
            // 血圧
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(children: [
                Expanded(
                  child: JogDialField(
                    label: '血圧 Low',
                    unit: 'mmHg',
                    icon: Icons.arrow_downward,
                    controller: lBpController,
                    config: _cfg(11),
                    onValueChanged: updateLBp,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Container(width: 5.0),
                Expanded(
                  child: JogDialField(
                    label: '血圧 High',
                    unit: 'mmHg',
                    icon: Icons.arrow_upward,
                    controller: hBpController,
                    config: _cfg(12),
                    onValueChanged: updateHBp,
                    onConfigChanged: _saveConfig,
                  ),
                ),
              ]),
            ),
            // レントゲン（テキスト）
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: TextField(
                controller: xRayController,
                style: textStyle,
                onChanged: (value) => updateXray(),
                decoration: InputDecoration(
                  labelText: 'レントゲン検査所見',
                  icon: const Icon(Icons.content_paste),
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            // 心電図（テキスト）
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: TextField(
                controller: eCgController,
                style: textStyle,
                onChanged: (value) => updateEcg(),
                decoration: InputDecoration(
                  labelText: '心電図検査所見',
                  labelStyle: textStyle,
                  icon: const Icon(Icons.accessibility),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            // 内科診察（テキスト）
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: TextField(
                controller: internalController,
                style: textStyle,
                onChanged: (value) => updateInternal(),
                decoration: InputDecoration(
                  labelText: '内科診察所見',
                  labelStyle: textStyle,
                  icon: const Icon(Icons.accessibility),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            // 血液検査セクション
            Row(children: [
              Expanded(child: Divider(color: Colors.red)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('血液検査',
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              ),
              Expanded(child: Divider(color: Colors.red)),
            ]),
            // 血清蛋白
            ExpansionTile(
              title: const Text('血清蛋白'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: '総蛋白',
                    unit: 'g/dL',
                    controller: totalProteinController,
                    config: _cfg(31),
                    onValueChanged: updateTotalProtein,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'アルブミン',
                    unit: 'g/dL',
                    controller: albuminController,
                    config: _cfg(32),
                    onValueChanged: updateAlbumin,
                    onConfigChanged: _saveConfig,
                  ),
                ),
              ],
            ),
            // 肝機能
            ExpansionTile(
              title: const Text('肝機能'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: '総ビリルビン',
                    unit: 'mg/dL',
                    controller: totalBilirubinController,
                    config: _cfg(33),
                    onValueChanged: updateTotalBilirubin,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'ＧＯＴ',
                    unit: 'U/L',
                    controller: gOtController,
                    config: _cfg(15),
                    onValueChanged: updateGot,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'ＧＰＴ',
                    unit: 'U/L',
                    controller: gPtController,
                    config: _cfg(16),
                    onValueChanged: updateGpt,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'ALP',
                    unit: 'U/L',
                    controller: alpController,
                    config: _cfg(34),
                    onValueChanged: updateAlp,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'ガンマGTP',
                    unit: 'U/L',
                    controller: gTpController,
                    config: _cfg(17),
                    onValueChanged: updateGtp,
                    onConfigChanged: _saveConfig,
                  ),
                ),
              ],
            ),
            // 脂質
            ExpansionTile(
              title: const Text('脂質'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: '総コレステロール',
                    unit: 'mg/dL',
                    controller: totalCholesterolController,
                    config: _cfg(35),
                    onValueChanged: updateTotalCholesterol,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'ＬＤＬ',
                    unit: 'mg/dL',
                    controller: lDlController,
                    config: _cfg(18),
                    onValueChanged: updateLdl,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'ＨＤＬ',
                    unit: 'mg/dL',
                    controller: hDlController,
                    config: _cfg(19),
                    onValueChanged: updateHdl,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: '中性脂肪',
                    unit: 'mg/dL',
                    controller: nFatController,
                    config: _cfg(20),
                    onValueChanged: updateNeutralfat,
                    onConfigChanged: _saveConfig,
                  ),
                ),
              ],
            ),
            // 尿酸
            ExpansionTile(
              title: const Text('尿酸'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: '尿酸',
                    unit: 'mg/dL',
                    controller: uricAcidController,
                    config: _cfg(36),
                    onValueChanged: updateUricAcid,
                    onConfigChanged: _saveConfig,
                  ),
                ),
              ],
            ),
            // 腎機能
            ExpansionTile(
              title: const Text('腎機能'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: '尿素窒素',
                    unit: 'mg/dL',
                    controller: ureaNitrogenController,
                    config: _cfg(37),
                    onValueChanged: updateUreaNitrogen,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'クレアチニン',
                    unit: 'mg/dL',
                    controller: creatinineController,
                    config: _cfg(38),
                    onValueChanged: updateCreatinine,
                    onConfigChanged: _saveConfig,
                  ),
                ),
              ],
            ),
            // アミラーゼ
            ExpansionTile(
              title: const Text('アミラーゼ'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'アミラーゼ',
                    unit: 'U/L',
                    controller: amylaseController,
                    config: _cfg(39),
                    onValueChanged: updateAmylase,
                    onConfigChanged: _saveConfig,
                  ),
                ),
              ],
            ),
            // 糖代謝
            ExpansionTile(
              title: const Text('糖代謝'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: '空腹時血糖',
                    unit: 'mg/dL',
                    controller: bGluController,
                    config: _cfg(21),
                    onValueChanged: updateBloodglucose,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'HbA1c',
                    unit: '%',
                    controller: hA1cController,
                    config: _cfg(22),
                    onValueChanged: updateHA1c,
                    onConfigChanged: _saveConfig,
                  ),
                ),
              ],
            ),
            // 白血球
            ExpansionTile(
              title: const Text('白血球数'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: '白血球',
                    unit: '/μL',
                    controller: whiteBloodCellController,
                    config: _cfg(40),
                    onValueChanged: updateWhiteBloodCell,
                    onConfigChanged: _saveConfig,
                  ),
                ),
              ],
            ),
            // 貧血
            ExpansionTile(
              title: const Text('貧血'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: '赤血球数',
                    unit: '万/μL',
                    controller: rBController,
                    config: _cfg(13),
                    onValueChanged: updateRedblood,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: '血色素量',
                    unit: 'g/dL',
                    controller: hEmoController,
                    config: _cfg(14),
                    onValueChanged: updateHemo,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'ヘマトクリット',
                    unit: '%',
                    controller: hematocritController,
                    config: _cfg(41),
                    onValueChanged: updateHematocrit,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'MCV',
                    unit: 'fL',
                    controller: mcvController,
                    config: _cfg(42),
                    onValueChanged: updateMcv,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'MCH',
                    unit: 'fL',
                    controller: mchController,
                    config: _cfg(43),
                    onValueChanged: updateMch,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'MCHC',
                    unit: '%',
                    controller: mchcController,
                    config: _cfg(44),
                    onValueChanged: updateMchc,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: '血清鉄',
                    unit: 'μg/dL',
                    controller: serumIronController,
                    config: _cfg(45),
                    onValueChanged: updateSerumIron,
                    onConfigChanged: _saveConfig,
                  ),
                ),
              ],
            ),
            // 血小板
            ExpansionTile(
              title: const Text('血小板'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: '血小板数',
                    unit: '万/μL',
                    controller: plateletController,
                    config: _cfg(46),
                    onValueChanged: updatePlatelet,
                    onConfigChanged: _saveConfig,
                  ),
                ),
              ],
            ),
            // 検尿・検便セクション
            Row(children: [
              Expanded(child: Divider(color: Colors.teal)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('検尿・検便',
                    style: const TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold)),
              ),
              Expanded(child: Divider(color: Colors.teal)),
            ]),
            ExpansionTile(
              title: const Text('検尿・検便'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: sugarController,
                    style: textStyle,
                    onChanged: (value) => updateSugar(),
                    decoration: InputDecoration(
                      labelText: '尿糖',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: urineController,
                    style: textStyle,
                    onChanged: (value) => updateUrine(),
                    decoration: InputDecoration(
                      labelText: '尿蛋白',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: latentBloodController,
                    style: textStyle,
                    onChanged: (value) => updateLatentBlood(),
                    decoration: InputDecoration(
                      labelText: '尿潜血',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: bloodInTheStoolController,
                    style: textStyle,
                    onChanged: (value) => updateBloodIn(),
                    decoration: InputDecoration(
                      labelText: '便潜血',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextField(
                    controller: memoController,
                    style: textStyle,
                    maxLines: 5,
                    onChanged: (value) => updateMemo(),
                    decoration: InputDecoration(
                      labelText: 'メモ',
                      labelStyle: textStyle,
                      icon: const Icon(Icons.note),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
              ],
            ),
            // 腫瘍マーカーセクション
            Row(children: [
              Expanded(child: Divider(color: Colors.purple)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('腫瘍マーカー',
                    style: const TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.bold)),
              ),
              Expanded(child: Divider(color: Colors.purple)),
            ]),
            ExpansionTile(
              title: const Text('腫瘍マーカー'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'CEA',
                    unit: 'ng/mL',
                    controller: ceaController,
                    config: _cfg(57),
                    onValueChanged: updateCea,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'AFP',
                    unit: 'ng/mL',
                    controller: afpController,
                    config: _cfg(58),
                    onValueChanged: updateAfp,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'PSA',
                    unit: 'ng/mL',
                    controller: psaController,
                    config: _cfg(59),
                    onValueChanged: updatePsa,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'CA19-9',
                    unit: 'U/mL',
                    controller: ca19_9Controller,
                    config: _cfg(60),
                    onValueChanged: updateCa19_9,
                    onConfigChanged: _saveConfig,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JogDialField(
                    label: 'CA125',
                    unit: 'U/mL',
                    controller: ca125Controller,
                    config: _cfg(61),
                    onValueChanged: updateCa125,
                    onConfigChanged: _saveConfig,
                  ),
                ),
              ],
            ),
            // 削除ボタン
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  textStyle: const TextStyle(color: Colors.red)),
              child: const Text('Delete', textScaleFactor: 1.5),
              onPressed: () {
                setState(() {
                  debugPrint('Delete button clicked');
                  _delete();
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (widget.model.on_the_day_24.isEmpty) {
              _showAlertDialog('警告', '受診日入力は必須です。');
            } else {
              _save();
            }
          });
        },
        tooltip: 'save',
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.save),
      ),
    );
  }

  void moveToLastScreen() => Navigator.pop(context, true);

  void updatePriorityAsInt(String value) {
    switch (value) {
      case '定期健康診断':
        widget.model.priority = 1;
        break;
      case '人間ドック':
        widget.model.priority = 2;
        break;
      case '独自検査':
        widget.model.priority = 3;
        break;
    }
  }

  String getPriorityAsString(int value) {
    switch (value) {
      case 1: return _priorities[0];
      case 2: return _priorities[1];
      case 3: return _priorities[2];
      default: return _priorities[0];
    }
  }

  void updateHeight() { widget.model.height_1 = heightController.text; }
  void updateWeight() { widget.model.weight_2 = weightController.text; }
  void updateWaist() { widget.model.waist_3 = waistController.text; }
  void updateREye() { widget.model.right_eye_4 = rEyeController.text; }
  void updateLEye() { widget.model.left_eye_5 = lEyeController.text; }
  void updateHearing_r_1000() { widget.model.hearing_right_1000_6 = hR1000Controller.text; }
  void updateHearing_l_1000() { widget.model.hearing_left_1000_7 = hL1000Controller.text; }
  void updateHearing_r_4000() { widget.model.hearing_right_4000_8 = hR4000Controller.text; }
  void updateHearing_l_4000() { widget.model.hearing_left_4000_9 = hL4000Controller.text; }
  void updateXray() { widget.model.x_ray_10 = xRayController.text; }
  void updateLBp() { widget.model.low_blood_pressure_11 = lBpController.text; }
  void updateHBp() { widget.model.high_blood_pressure_12 = hBpController.text; }
  void updateRedblood() { widget.model.red_blood_13 = rBController.text; }
  void updateHemo() { widget.model.hemoglobin_14 = hEmoController.text; }
  void updateGot() { widget.model.got_15 = gOtController.text; }
  void updateGpt() { widget.model.gpt_16 = gPtController.text; }
  void updateGtp() { widget.model.gtp_17 = gTpController.text; }
  void updateLdl() { widget.model.ldl_18 = lDlController.text; }
  void updateHdl() { widget.model.hdl_19 = hDlController.text; }
  void updateNeutralfat() { widget.model.neutral_fat_20 = nFatController.text; }
  void updateBloodglucose() { widget.model.blood_glucose_21 = bGluController.text; }
  void updateHA1c() { widget.model.hA1c_22 = hA1cController.text; }
  void updateEcg() { widget.model.ecg_23 = eCgController.text; }
  void updateInternal() { widget.model.internal_47 = internalController.text; }
  void updateSugar() { widget.model.sugar_26 = sugarController.text; }
  void updateUrine() { widget.model.urine_25 = urineController.text; }
  void updateCorrectER() { widget.model.correctedEyesight_right_27 = correctEyeRController.text; }
  void updateCorrectEL() { widget.model.correctedEyesight_left_28 = correctEyeLController.text; }
  void updateLatentBlood() { widget.model.latentBlood_29 = latentBloodController.text; }
  void updateBloodIn() { widget.model.bloodInTheStool_30 = bloodInTheStoolController.text; }
  void updateTotalProtein() { widget.model.totalProtein_31 = totalProteinController.text; }
  void updateAlbumin() { widget.model.albumin_32 = albuminController.text; }
  void updateTotalBilirubin() { widget.model.totalBilirubin_33 = totalBilirubinController.text; }
  void updateAlp() { widget.model.alp_34 = alpController.text; }
  void updateTotalCholesterol() { widget.model.totalCholesterol_35 = totalCholesterolController.text; }
  void updateUricAcid() { widget.model.uricAcid_36 = uricAcidController.text; }
  void updateUreaNitrogen() { widget.model.ureaNitrogen_37 = ureaNitrogenController.text; }
  void updateCreatinine() { widget.model.creatinine_38 = creatinineController.text; }
  void updateAmylase() { widget.model.amylase_39 = amylaseController.text; }
  void updateWhiteBloodCell() { widget.model.whiteBloodCell_40 = whiteBloodCellController.text; }
  void updateHematocrit() { widget.model.hematocrit_41 = hematocritController.text; }
  void updateMcv() { widget.model.mcv_42 = mcvController.text; }
  void updateMch() { widget.model.mch_43 = mchController.text; }
  void updateMchc() { widget.model.mchc_44 = mchcController.text; }
  void updateSerumIron() { widget.model.serumIron_45 = serumIronController.text; }
  void updatePlatelet() { widget.model.platelet_46 = plateletController.text; }
  void updateMemo() { widget.model.memo_48 = memoController.text; }
  void updateEyePressureR() { widget.model.eyePressureRight_49 = eyePressureRController.text; }
  void updateEyePressureL() { widget.model.eyePressureLeft_50 = eyePressureLController.text; }
  void updateContactR() { widget.model.contactRight_51 = contactRController.text; }
  void updateContactL() { widget.model.contactLeft_52 = contactLController.text; }
  void updateAstigR() { widget.model.astigRight_53 = astigRController.text; }
  void updateAstigL() { widget.model.astigLeft_54 = astigLController.text; }
  void updateAxisR() { widget.model.axisRight_55 = axisRController.text; }
  void updateAxisL() { widget.model.axisLeft_56 = axisLController.text; }
  void updateCea() { widget.model.cea_57 = ceaController.text; }
  void updateAfp() { widget.model.afp_58 = afpController.text; }
  void updatePsa() { widget.model.psa_59 = psaController.text; }
  void updateCa19_9() { widget.model.ca19_9_60 = ca19_9Controller.text; }
  void updateCa125() { widget.model.ca125_61 = ca125Controller.text; }

  void updateOTD() {
    widget.model.on_the_day_24 = onTheDayController.text;
    if (kDebugMode) print(widget.model.on_the_day_24);
  }

  Future<void> _showDialog() async {
    double? selectedValue = await showDialog<double>(
      context: context,
      builder: (BuildContext context) => NumberSelectDialog(
        selectedValue: _selectedValue,
        minValue: _minValue,
        maxValue: _maxValue,
      ),
    );
    if (selectedValue != null) {
      setState(() => _selectedValue = selectedValue);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      locale: const Locale("ja"),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now().add(const Duration(days: 720)),
    );
    if (selected != null) {
      setState(() =>
          dateNow = DateFormat("yyyy年MM月dd日").format(selected).toString());
      onTheDayController.text = dateNow;
      updateOTD();
    }
  }

  void _save() async {
    widget.model.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (widget.model.id != null) {
      result = await helper.updateModel(widget.model);
    } else {
      result = await helper.insertModel(widget.model);
    }
    if (result != 0) {
      moveToLastScreen();
    } else {
      _showAlertDialog('状況', '問題発生・保存されませんでした');
    }
  }

  void _delete() async {
    moveToLastScreen();
    if (widget.model.id == null) {
      _showAlertDialog('状況', '削除データなし');
      return;
    }
    int result = await helper.deleteModel(widget.model.id!);
    if (result != 0) {
      _showAlertDialog('状況', 'データ削除完了');
    } else {
      _showAlertDialog('状況', '問題発生・データ削除不可');
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class NumberSelectDialog extends StatefulWidget {
  final double selectedValue;
  final double minValue;
  final double maxValue;

  const NumberSelectDialog({
    super.key,
    required this.selectedValue,
    required this.minValue,
    required this.maxValue,
  });

  @override
  _NumberSelectDialogState createState() => _NumberSelectDialogState();
}

class _NumberSelectDialogState extends State<NumberSelectDialog> {
  late double _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select a number'),
      content: SingleChildScrollView(
        child: ListBody(
          children: List<Widget>.generate(
            ((widget.maxValue - widget.minValue) * 10).toInt(),
            (index) {
              double value = widget.minValue + (index / 10);
              return RadioListTile<double>(
                value: value,
                groupValue: _selectedValue,
                title: Text(value.toStringAsFixed(1)),
                onChanged: (double? value) {
                  setState(() => _selectedValue = value!);
                },
              );
            },
          ),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('CANCEL'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context).pop(_selectedValue),
        ),
      ],
    );
  }
}
