class FieldConfig {
  int? id;
  final int fieldKey;
  double? lower;
  double? upper;
  double step;
  double dialMin;
  double dialMax;
  double? defaultValue;

  FieldConfig({
    this.id,
    required this.fieldKey,
    this.lower,
    this.upper,
    required this.step,
    required this.dialMin,
    required this.dialMax,
    this.defaultValue,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'field_key': fieldKey,
        'lower': lower,
        'upper': upper,
        'step': step,
        'dial_min': dialMin,
        'dial_max': dialMax,
        'default_value': defaultValue,
      };

  factory FieldConfig.fromMap(Map<String, dynamic> map) => FieldConfig(
        id: map['id'] as int?,
        fieldKey: map['field_key'] as int,
        lower: map['lower'] != null ? (map['lower'] as num).toDouble() : null,
        upper: map['upper'] != null ? (map['upper'] as num).toDouble() : null,
        step: (map['step'] as num).toDouble(),
        dialMin: (map['dial_min'] as num).toDouble(),
        dialMax: (map['dial_max'] as num).toDouble(),
        defaultValue: map['default_value'] != null
            ? (map['default_value'] as num).toDouble()
            : null,
      );
}
