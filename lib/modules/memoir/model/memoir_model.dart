// To parse this JSON data, do
//
//     final MemoirApiModel = MemoirApiModelFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators, prefer_if_null_operators

import 'dart:convert';

MemoirApiModel memoirApiModelFromJson(String str) =>
    MemoirApiModel.fromJson(json.decode(str));

String memoirApiModelToJson(MemoirApiModel data) => json.encode(data.toJson());

class MemoirApiModel {
  MemoirApiModel({
    this.pagination,
    this.data,
  });

  Pagination? pagination;
  List<MemoirModel>? data;

  factory MemoirApiModel.fromJson(Map<String, dynamic> json) => MemoirApiModel(
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null
            ? null
            : List<MemoirModel>.from(json["data"].map((x) => MemoirModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination == null ? null : pagination!.toJson(),
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MemoirModel {
  MemoirModel({
    this.author,
    this.title,
    this.description,
    this.url,
    this.source,
    this.image,
    this.category,
    this.language,
    this.country,
    this.publishedAt,
  });

  String? author;
  String? title;
  String? description;
  String? url;
  String? source;
  String? image;
  Category? category;
  Language? language;
  Country? country;
  DateTime? publishedAt;

  factory MemoirModel.fromJson(Map<String, dynamic> json) => MemoirModel(
        author: json["author"] == null ? null : json["author"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        url: json["url"] == null ? null : json["url"],
        source: json["source"] == null ? null : json["source"],
        image: json["image"] == null ? null : json["image"],
        category: json["category"] == null
            ? null
            : categoryValues.map[json["category"]],
        language: json["language"] == null
            ? null
            : languageValues.map[json["language"]],
        country:
            json["country"] == null ? null : countryValues.map[json["country"]],
        publishedAt: json["published_at"] == null
            ? null
            : DateTime.parse(json["published_at"]),
      );

  Map<String, dynamic> toJson() => {
        "author": author == null ? null : author,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "url": url == null ? null : url,
        "source": source == null ? null : source,
        "image": image == null ? null : image,
        "category": category == null ? null : categoryValues.reverse[category],
        "language": language == null ? null : languageValues.reverse[language],
        "country": country == null ? null : countryValues.reverse[country],
        "published_at":
            publishedAt == null ? null : publishedAt!.toIso8601String(),
      };
}

enum Category { GENERAL }

final categoryValues = EnumValues({"general": Category.GENERAL});

enum Country { EG, PS, MA, QA }

final countryValues = EnumValues(
    {"eg": Country.EG, "ma": Country.MA, "ps": Country.PS, "qa": Country.QA});

enum Language { AR }

final languageValues = EnumValues({"ar": Language.AR});

class Pagination {
  Pagination({
    this.limit,
    this.offset,
    this.count,
    this.total,
  });

  int? limit;
  int? offset;
  int? count;
  int? total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        limit: json["limit"] == null ? null : json["limit"],
        offset: json["offset"] == null ? null : json["offset"],
        count: json["count"] == null ? null : json["count"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit == null ? null : limit,
        "offset": offset == null ? null : offset,
        "count": count == null ? null : count,
        "total": total == null ? null : total,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
