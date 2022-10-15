// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_memoir_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomMemoirModelAdapter extends TypeAdapter<CustomMemoirModel> {
  @override
  final int typeId = 2;

  @override
  CustomMemoirModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomMemoirModel(
      id: fields[0] as String?,
      author: fields[1] as String?,
      title: fields[2] as String?,
      username: fields[5] as String?,
      description: fields[3] as String?,
      publishedAt: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, CustomMemoirModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.publishedAt)
      ..writeByte(5)
      ..write(obj.username);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomMemoirModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
