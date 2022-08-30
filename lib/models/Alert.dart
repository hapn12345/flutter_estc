// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 1)
class Alert {
  @HiveField(0)
  bool isActive = false;
  @HiveField(1)
  String defId = "0";
  @HiveField(2)
  String nameAlert = "";
  @HiveField(3)
  String dateTime = "";
  @HiveField(4)
  String tag = "";
  @HiveField(5)
  int level = 0;
  @HiveField(6)
  String category = "";
  @HiveField(7)
  String value = "";
  @HiveField(8)
  String upperLimit = "";
  @HiveField(9)
  String lowerLimit = "";
  Alert({
    required this.isActive,
    required this.defId,
    required this.nameAlert,
    required this.dateTime,
    required this.tag,
    required this.level,
    required this.category,
    required this.value,
    required this.upperLimit,
    required this.lowerLimit,
  });

  Alert copyWith({
    bool? isActive,
    String? defId,
    String? nameAlert,
    String? dateTime,
    String? tag,
    int? level,
    String? category,
    String? value,
    String? upperLimit,
    String? lowerLimit,
  }) {
    return Alert(
      isActive: isActive ?? this.isActive,
      defId: defId ?? this.defId,
      nameAlert: nameAlert ?? this.nameAlert,
      dateTime: dateTime ?? this.dateTime,
      tag: tag ?? this.tag,
      level: level ?? this.level,
      category: category ?? this.category,
      value: value ?? this.value,
      upperLimit: upperLimit ?? this.upperLimit,
      lowerLimit: lowerLimit ?? this.lowerLimit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isActive': isActive,
      'defId': defId,
      'nameAlert': nameAlert,
      'dateTime': dateTime,
      'tag': tag,
      'level': level,
      'category': category,
      'value': value,
      'upperLimit': upperLimit,
      'lowerLimit': lowerLimit,
    };
  }

  factory Alert.fromMap(Map<String, dynamic> map) {
    return Alert(
      isActive: map['isActive'] as bool,
      defId: map['defId'] as String,
      nameAlert: map['nameAlert'] as String,
      dateTime: map['dateTime'] as String,
      tag: map['tag'] as String,
      level: map['level'] as int,
      category: map['category'] as String,
      value: map['value'] as String,
      upperLimit: map['upperLimit'] as String,
      lowerLimit: map['lowerLimit'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Alert.fromJson(String source) =>
      Alert.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Alert(isActive: $isActive, defId: $defId, nameAlert: $nameAlert, dateTime: $dateTime, tag: $tag, level: $level, category: $category, value: $value, upperLimit: $upperLimit, lowerLimit: $lowerLimit)';
  }

  @override
  bool operator ==(covariant Alert other) {
    if (identical(this, other)) return true;

    return other.isActive == isActive &&
        other.defId == defId &&
        other.nameAlert == nameAlert &&
        other.dateTime == dateTime &&
        other.tag == tag &&
        other.level == level &&
        other.category == category &&
        other.value == value &&
        other.upperLimit == upperLimit &&
        other.lowerLimit == lowerLimit;
  }

  @override
  int get hashCode {
    return isActive.hashCode ^
        defId.hashCode ^
        nameAlert.hashCode ^
        dateTime.hashCode ^
        tag.hashCode ^
        level.hashCode ^
        category.hashCode ^
        value.hashCode ^
        upperLimit.hashCode ^
        lowerLimit.hashCode;
  }
}
