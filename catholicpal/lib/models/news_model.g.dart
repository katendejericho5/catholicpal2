// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyNewsAdapter extends TypeAdapter<DailyNews> {
  @override
  final int typeId = 1;

  @override
  DailyNews read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyNews(
      title: fields[0] as String,
      link: fields[1] as String,
      description: fields[2] as String,
      imageUrl: fields[3] as String,
      publishDate: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DailyNews obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.link)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.publishDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyNewsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
