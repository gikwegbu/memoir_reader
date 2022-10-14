// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AiSettingsModelAdapter extends TypeAdapter<AiSettingsModel> {
  @override
  final int typeId = 1;

  @override
  AiSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AiSettingsModel(
      volume: fields[0] as double?,
      pitch: fields[1] as double?,
      speechRate: fields[2] as double?,
      languages: (fields[3] as List?)?.cast<String>(),
      langCode: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AiSettingsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.volume)
      ..writeByte(1)
      ..write(obj.pitch)
      ..writeByte(2)
      ..write(obj.speechRate)
      ..writeByte(3)
      ..write(obj.languages)
      ..writeByte(4)
      ..write(obj.langCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AiSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
