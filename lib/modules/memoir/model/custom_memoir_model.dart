// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:hive_flutter/hive_flutter.dart';

part 'custom_memoir_model.g.dart';

@HiveType(typeId: 2)
class CustomMemoirModel extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? author;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? description;
  @HiveField(4)
  DateTime? publishedAt;
  @HiveField(5)
  String? username;

  CustomMemoirModel({
    this.id,
    this.author,
    this.title,
    this.username,
    this.description,
    this.publishedAt,
  });

  CustomMemoirModel copyWith({
    String? id,
    String? author,
    String? title,
    String? username,
    String? description,
    DateTime? publishedAt,
  }) =>
      CustomMemoirModel(
        id: id ?? this.id,
        author: author ?? this.author,
        title: title ?? this.title,
        username: username ?? this.username,
        description: description ?? this.description,
        publishedAt: publishedAt ?? this.publishedAt,
      );

  factory CustomMemoirModel.fromJson(Map<String, dynamic> json) =>
      CustomMemoirModel(
        id: json['id'] ?? null,
        author: json['author'] ?? null,
        title: json['title'] ?? null,
        username: json['username'] ?? null,
        description: json['description'] ?? null,
        publishedAt: json['publishedAt'] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "title": title,
        "username": username,
        "description": description,
        "publishedAt": publishedAt,
      };
}
