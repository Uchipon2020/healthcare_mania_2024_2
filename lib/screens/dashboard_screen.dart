import 'package:flutter/material.dart';

import '../models/model.dart';

class DashboardScreen extends StatelessWidget {
  final List<Model> modelList;

  const DashboardScreen({super.key, required this.modelList});

  @override
  Widget build(BuildContext context) {
    final sorted = [...modelList]
      ..sort((a, b) => b.on_the_day_24.compareTo(a.on_the_day_24));
    final latest = sorted.isNotEmpty ? sorted.first : null;

    if (latest == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('ダッシュボード')),
        body: const Center(child: Text('データがありません！！')),
      );
    }

    return Scaffold(
        appBar: AppBar(title: const Text('ダッシュボード')),
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ListView(children: [
            Text('最終受診日：${latest.on_the_day_24}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildCard('基本情報', [
              _buildRow('体重', latest.weight_2, 'kg', null, null),
              _buildRow(
                  '血圧（上）', latest.high_blood_pressure_12, 'mmHg', 90, 139),
              _buildRow('血圧（下）', latest.low_blood_pressure_11, 'mmHg', 60, 89),
            ]),
            const SizedBox(height: 8),
            _buildCard('糖代謝', [
              _buildRow('血糖', latest.blood_glucose_21, 'mg/dL', null, 99),
              _buildRow('HbA1c', latest.hA1c_22, '%', null, 5.9),
            ]),
            const SizedBox(height: 8),
            _buildCard('脂質', [
              _buildRow('LDL', latest.ldl_18, 'mg/dL', 70, 139),
              _buildRow('HDL', latest.hdl_19, 'mg/dL', 40, 99),
              _buildRow('中性脂肪', latest.neutral_fat_20, 'mg/dL', null, 149),
              _buildRow(
                  '総コレステロール', latest.totalCholesterol_35, 'mg/dL', null, 219),
            ]),
            const SizedBox(height: 8),
            _buildCard('肝機能', [
              _buildRow('GOT', latest.got_15, 'U/L', 10, 40),
              _buildRow('GPT', latest.gpt_16, 'U/L', 5, 45),
              _buildRow('γ-GTP', latest.gtp_17, 'U/L', 10, 50),
              _buildRow('ALP', latest.alp_34, 'U/L', null, 120),
            ]),
            const SizedBox(height: 8),
            _buildCard('腎機能', [
              _buildRow('尿素窒素', latest.ureaNitrogen_37, 'mg/dL', 8, 22),
              _buildRow('クレアチニン', latest.creatinine_38, 'mg/dL', null, 1.07),
            ]),
          ]),
        ));
  }

  Widget _buildCard(String title, List<Widget> rows) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...rows,
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
      String label, String value, String unit, double? lower, double? upper) {
    if (value.isEmpty) return const SizedBox.shrink();
    final numValue = double.tryParse(value);
    Color color = Colors.black;
    if (numValue != null) {
      if (lower != null && numValue < lower) color = Colors.red;
      if (upper != null && numValue > upper) color = Colors.red;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text('$value $unit',
              style: TextStyle(fontWeight: FontWeight.bold, color: color))
        ],
      ),
    );
  }
}
