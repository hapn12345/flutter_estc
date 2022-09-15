import 'package:hive/hive.dart';
import 'dart:math';

part 'log_item.g.dart';

@HiveType(typeId: 1)
class LogItem extends HiveObject {
  @HiveField(0)
  String key;

  @HiveField(1)
  String logId;

  @HiveField(2)
  DateTime time;

  @HiveField(3)
  String accountName;

  @HiveField(4)
  String diaryType;

  @HiveField(5)
  String prority;

  @HiveField(6)
  String note;

  @HiveField(7)
  String description;
  LogItem({
    required this.key,
    required this.logId,
    required this.time,
    required this.accountName,
    required this.diaryType,
    required this.prority,
    required this.note,
    required this.description,
  });

  @override
  String toString() {
    return 'LogItem( key: $key, logId: $logId, time: $time, accountName: $accountName, diaryType: $diaryType, prority: $prority, note: $note, description: $description)';
  }
}
