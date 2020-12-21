// To parse this JSON data, do
//
//     final chapterList = chapterListFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ChapterList {
  ChapterList({
    @required this.chapters,
  });

  List<Chapter> chapters;

  factory ChapterList.fromJson(String str) =>
      ChapterList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChapterList.fromMap(Map<String, dynamic> json) => ChapterList(
        chapters: json["chapters"] == null
            ? null
            : List<Chapter>.from(
                json["chapters"].map((x) => Chapter.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "chapters": chapters == null
            ? null
            : List<dynamic>.from(chapters.map((x) => x.toMap())),
      };
}

class Chapter {
  Chapter({
    @required this.chapterClass,
    @required this.chapter,
    @required this.name,
    @required this.information,
  });

  int chapterClass;
  int chapter;
  String name;
  String information;

  factory Chapter.fromJson(String str) => Chapter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Chapter.fromMap(Map<String, dynamic> json) => Chapter(
        chapterClass: json["class"] == null ? null : json["class"],
        chapter: json["chapter"] == null ? null : json["chapter"],
        name: json["name"] == null ? null : json["name"],
        information: json["information"] == null ? null : json["information"],
      );

  Map<String, dynamic> toMap() => {
        "class": chapterClass == null ? null : chapterClass,
        "chapter": chapter == null ? null : chapter,
        "name": name == null ? null : name,
        "information": information == null ? null : information,
      };
}
