// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogItemAdapter extends TypeAdapter<LogItem> {
  @override
  final int typeId = 1;

  @override
  LogItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogItem(
      key: fields[0] as String,
      logId: fields[1] as String,
      time: fields[2] as DateTime,
      accountName: fields[3] as String,
      diaryType: fields[4] as String,
      prority: fields[5] as String,
      note: fields[6] as String,
      description: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LogItem obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.logId)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.accountName)
      ..writeByte(4)
      ..write(obj.diaryType)
      ..writeByte(5)
      ..write(obj.prority)
      ..writeByte(6)
      ..write(obj.note)
      ..writeByte(7)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
