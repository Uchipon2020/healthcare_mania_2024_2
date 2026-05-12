import 'package:flutter/material.dart';
import '../models/field_config.dart';

class JogDialField extends StatefulWidget {
  final String label;
  final String? unit;
  final IconData? icon;
  final TextEditingController controller;
  final FieldConfig config;
  final VoidCallback onValueChanged;
  final Function(FieldConfig) onConfigChanged;

  const JogDialField({
    super.key,
    required this.label,
    this.unit,
    this.icon,
    required this.controller,
    required this.config,
    required this.onValueChanged,
    required this.onConfigChanged,
  });

  @override
  State<JogDialField> createState() => _JogDialFieldState();
}

class _JogDialFieldState extends State<JogDialField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(JogDialField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onControllerChanged);
      widget.controller.addListener(_onControllerChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() => setState(() {});

  int get _decimalPlaces {
    final s = widget.config.step;
    if (s >= 1) return 0;
    if (s >= 0.1) return 1;
    if (s >= 0.01) return 2;
    return 3;
  }

  String _fmt(double v) => v.toStringAsFixed(_decimalPlaces);

  List<double> _buildValues() {
    final cfg = widget.config;
    final dec = _decimalPlaces;
    final count = ((cfg.dialMax - cfg.dialMin) / cfg.step).round() + 1;
    return List.generate(count, (i) {
      final v = cfg.dialMin + i * cfg.step;
      return double.parse(v.toStringAsFixed(dec + 2));
    });
  }

  Color get _valueColor {
    final v = double.tryParse(widget.controller.text);
    if (v == null) return Colors.grey;
    final upper = widget.config.upper;
    final lower = widget.config.lower;
    if (upper != null && v > upper) return Colors.red;
    if (lower != null && v < lower) return Colors.blue;
    return Colors.black87;
  }

  Future<void> _showPicker(BuildContext context) async {
    final values = _buildValues();
    final currentValue = double.tryParse(widget.controller.text) ??
        widget.config.defaultValue;

    int initialIndex = 0;
    if (currentValue != null && values.isNotEmpty) {
      double minDiff = double.infinity;
      for (int i = 0; i < values.length; i++) {
        final diff = (values[i] - currentValue).abs();
        if (diff < minDiff) {
          minDiff = diff;
          initialIndex = i;
        }
      }
    }

    final scrollCtrl =
        FixedExtentScrollController(initialItem: initialIndex);
    int selectedIndex = initialIndex;

    final result = await showDialog<double>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(widget.label),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        content: SizedBox(
          height: 200,
          width: 220,
          child: ListWheelScrollView.useDelegate(
            controller: scrollCtrl,
            itemExtent: 48,
            perspective: 0.005,
            diameterRatio: 1.4,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (i) => selectedIndex = i,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: values.length,
              builder: (_, i) => Center(
                child: Text(
                  '${_fmt(values[i])}${widget.unit != null ? '  ${widget.unit}' : ''}',
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              widget.controller.text = '';
              widget.onValueChanged();
              Navigator.pop(ctx);
            },
            child: const Text('クリア'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.pop(ctx, values[selectedIndex]),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    if (result != null) {
      widget.controller.text = _fmt(result);
      widget.onValueChanged();
    }
  }

  Future<void> _showConfigDialog(BuildContext context) async {
    final cfg = widget.config;
    final lowerCtrl =
        TextEditingController(text: cfg.lower?.toString() ?? '');
    final upperCtrl =
        TextEditingController(text: cfg.upper?.toString() ?? '');
    final stepCtrl = TextEditingController(text: cfg.step.toString());
    final minCtrl = TextEditingController(text: cfg.dialMin.toString());
    final maxCtrl = TextEditingController(text: cfg.dialMax.toString());
    final defaultCtrl =
        TextEditingController(text: cfg.defaultValue?.toString() ?? '');

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${widget.label}  の設定'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _cfgRow(lowerCtrl, '正常値 下限（未設定は空欄）'),
              _cfgRow(upperCtrl, '正常値 上限（未設定は空欄）'),
              _cfgRow(stepCtrl, '刻み幅'),
              _cfgRow(minCtrl, 'ダイヤル 最小値'),
              _cfgRow(maxCtrl, 'ダイヤル 最大値'),
              _cfgRow(defaultCtrl, 'デフォルト値（未設定は空欄）'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () {
              final updated = FieldConfig(
                id: cfg.id,
                fieldKey: cfg.fieldKey,
                lower: double.tryParse(lowerCtrl.text),
                upper: double.tryParse(upperCtrl.text),
                step: double.tryParse(stepCtrl.text) ?? cfg.step,
                dialMin: double.tryParse(minCtrl.text) ?? cfg.dialMin,
                dialMax: double.tryParse(maxCtrl.text) ?? cfg.dialMax,
                defaultValue: double.tryParse(defaultCtrl.text),
              );
              widget.onConfigChanged(updated);
              Navigator.pop(ctx);
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  Widget _cfgRow(TextEditingController ctrl, String label) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: TextField(
          controller: ctrl,
          keyboardType: const TextInputType.numberWithOptions(
              decimal: true, signed: true),
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;
    final raw = widget.controller.text;
    final displayText = raw.isNotEmpty
        ? raw
        : (widget.config.defaultValue != null
            ? _fmt(widget.config.defaultValue!)
            : '---');
    final isDefault = raw.isEmpty;

    return GestureDetector(
      onTap: () => _showPicker(context),
      onLongPress: () => _showConfigDialog(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: textStyle,
          icon: widget.icon != null ? Icon(widget.icon) : null,
          suffix: widget.unit != null ? Text(widget.unit!) : null,
          suffixIcon: const Icon(Icons.arrow_drop_down, size: 20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0)),
        ),
        child: Text(
          displayText,
          textAlign: TextAlign.right,
          style: textStyle?.copyWith(
            color: isDefault ? Colors.grey : _valueColor,
          ),
        ),
      ),
    );
  }
}
