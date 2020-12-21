import 'dart:async';

import 'package:class_room/BLOC/bloc.dart';
import 'package:class_room/models/chapters_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChapterBloc implements Bloc {
  final _chapterController = StreamController<List<Chapter>>.broadcast();

  Stream<List<Chapter>> get chapterStream => _chapterController.stream;

  void fetchData(String jsonFile) async {
    List<Chapter> _chapter = [];
    String data = await rootBundle.loadString(jsonFile);
    for (int i = 0; i < ChapterList.fromJson(data).chapters.length; i++) {
      _chapter.add(ChapterList.fromJson(data).chapters[i]);
    }
    print(_chapter.length);
    _chapterController.sink.add(_chapter);
  }

  @override
  void dispose() {
    _chapterController.close();
  }
}
