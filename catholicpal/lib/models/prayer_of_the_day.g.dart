// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_of_the_day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrayerOfTheDayAdapter extends TypeAdapter<PrayerOfTheDay> {
  @override
  final int typeId = 1;

  @override
  PrayerOfTheDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrayerOfTheDay(
      title: fields[0] as String,
      link: fields[1] as String,
      description: fields[2] as String,
      publishDate: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PrayerOfTheDay obj) {
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
      other is PrayerOfTheDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
