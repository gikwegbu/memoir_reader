// ignore_for_file: unnecessary_null_in_if_null_operators
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'profile_model.g.dart';

@HiveType(typeId: 0)
class ProfileModel extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? fullname;
  @HiveField(2)
  String? username;
  @HiveField(3)
  String? imageUrl;
  @HiveField(4)
  String? whatsappUrl;
  @HiveField(5)
  String? twitterUrl;
  @HiveField(6)
  String? instagramUrl;
  @HiveField(7)
  String? linkedinUrl;

  ProfileModel({
    this.id,
    this.fullname,
    this.username,
    this.imageUrl,
    this.whatsappUrl,
    this.instagramUrl,
    this.linkedinUrl,
    this.twitterUrl,
  });

  ProfileModel copyWith({
    String? id,
    String? fullname,
    String? username,
    String? imageUrl,
    String? whatsappUrl,
    String? instagramUrl,
    String? linkedinUrl,
    String? twitterUrl,
  }) =>
      ProfileModel(
        id: id ?? this.id,
        fullname: fullname ?? this.fullname,
        username: username ?? this.username,
        imageUrl: imageUrl ?? this.imageUrl,
        whatsappUrl: whatsappUrl ?? this.whatsappUrl,
        instagramUrl: instagramUrl ?? this.instagramUrl,
        linkedinUrl: linkedinUrl ?? this.linkedinUrl,
        twitterUrl: twitterUrl ?? this.twitterUrl,
      );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json['id'] ?? null,
        fullname: json['fullname'] ?? null,
        username: json['username'] ?? null,
        imageUrl: json['imageUrl'] ?? null,
        whatsappUrl: json['whatsappUrl'] ?? null,
        instagramUrl: json['instagramUrl'] ?? null,
        linkedinUrl: json['linkedinUrl'] ?? null,
        twitterUrl: json['twitterUrl'] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "username": username,
        "imageUrl": imageUrl,
        "whatsappUrl": whatsappUrl,
        "instagramUrl": instagramUrl,
        "linkedinUrl": linkedinUrl,
        "twitterUrl": twitterUrl,
      };
}
