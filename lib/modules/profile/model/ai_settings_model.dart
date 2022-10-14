// ignore_for_file: unnecessary_null_in_if_null_operators
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'ai_settings_model.g.dart';

@HiveType(typeId: 1)
class AiSettingsModel extends HiveObject {
  @HiveField(0)
  double? volume;
  @HiveField(1)
  double? pitch;
  @HiveField(2)
  double? speechRate;
  @HiveField(3)
  List<String>? languages;
  @HiveField(4)
  String? langCode;

  AiSettingsModel({
    this.volume = 1.0,
    this.pitch = 1.0,
    this.speechRate = 0.5,
    this.languages,
    this.langCode = "en-US",
  });

  AiSettingsModel copyWith({
    double? volume,
    double? pitch,
    double? speechRate,
    List<String>? languages,
    String? langCode,
  }) =>
      AiSettingsModel(
        volume: volume ?? this.volume,
        pitch: pitch ?? this.pitch,
        speechRate: speechRate ?? this.speechRate,
        langCode: langCode ?? this.langCode,
        languages: languages ?? this.languages,
      );

  factory AiSettingsModel.fromJson(Map<String, dynamic> json) =>
      AiSettingsModel(
        volume: json['volume'] ?? null,
        pitch: json['pitch'] ?? null,
        speechRate: json['speechRate'] ?? null,
        languages: json['languages'] == null
            ? null
            : List<String>.from(json['languages']),
        langCode: json['langCode'] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "volume": volume,
        "pitch": pitch,
        "speechRate": speechRate,
        "languages": languages,
        "langCode": langCode,
      };
}
