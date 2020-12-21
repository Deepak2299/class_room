// To parse this JSON data, do
//
//     final assignmentList = assignmentListFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class AssignmentList {
  AssignmentList({
    @required this.assignments,
  });

  List<Assignment> assignments;

  factory AssignmentList.fromJson(String str) =>
      AssignmentList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AssignmentList.fromMap(Map<String, dynamic> json) => AssignmentList(
        assignments: json["assignments"] == null
            ? null
            : List<Assignment>.from(
                json["assignments"].map((x) => Assignment.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "assignments": assignments == null
            ? null
            : List<dynamic>.from(assignments.map((x) => x.toMap())),
      };
}

class Assignment {
  Assignment({
    @required this.assignmentClass,
    @required this.name,
    @required this.information,
    @required this.date,
  });

  int assignmentClass;
  String name;
  String information;
  String date;

  factory Assignment.fromJson(String str) =>
      Assignment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Assignment.fromMap(Map<String, dynamic> json) => Assignment(
        assignmentClass: json["class"] == null ? null : json["class"],
        name: json["name"] == null ? null : json["name"],
        information: json["information"] == null ? null : json["information"],
        date: json["date"] == null ? null : json["date"],
      );

  Map<String, dynamic> toMap() => {
        "class": assignmentClass == null ? null : assignmentClass,
        "name": name == null ? null : name,
        "information": information == null ? null : information,
        "date": date == null ? null : date,
      };
}
