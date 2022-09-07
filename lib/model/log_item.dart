import 'package:hive/hive.dart';

part 'log_item.g.dart';

@HiveType(typeId: 1)
class LogItem extends HiveObject {
  @HiveField(0)
  String logId;

  @HiveField(1)
  DateTime time;

  @HiveField(2)
  String accountName;

  @HiveField(3)
  String diaryType;

  @HiveField(4)
  String prority;

  @HiveField(5)
  String note;

  @HiveField(6)
  String description;
  LogItem({
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
    return 'LogItem(logId: $logId, time: $time, accountName: $accountName, diaryType: $diaryType, prority: $prority, note: $note, description: $description)';
  }
}
