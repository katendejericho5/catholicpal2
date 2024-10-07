// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_reading.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyReadingAdapter extends TypeAdapter<DailyReading> {
  @override
  final int typeId = 4;

  @override
  DailyReading read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyReading(
      title: fields[0] as String,
      link: fields[1] as String,
      description: fields[2] as String,
      publishDate: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DailyReading obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.link)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.publishDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyReadingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
