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
      logId: fields[0] as String,
      time: fields[1] as DateTime,
      accountName: fields[2] as String,
      diaryType: fields[3] as String,
      prority: fields[4] as String,
      note: fields[5] as String,
      description: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LogItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.logId)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.accountName)
      ..writeByte(3)
      ..write(obj.diaryType)
      ..writeByte(4)
      ..write(obj.prority)
      ..writeByte(5)
      ..write(obj.note)
      ..writeByte(6)
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
