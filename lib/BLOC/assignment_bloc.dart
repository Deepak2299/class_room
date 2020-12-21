import 'dart:async';

import 'package:class_room/BLOC/bloc.dart';
import 'package:class_room/models/assignment_list_model.dart';
import 'package:flutter/services.dart';

class AssignmentBloc implements Bloc {
  Assignment _assignment;
  Assignment get selectedAssignment => _assignment;
  final _assignmentController = StreamController<List<Assignment>>.broadcast();

  Stream<List<Assignment>> get assignmentStream => _assignmentController.stream;

  void fetchData(String jsonFile) async {
    String data = await rootBundle.loadString(jsonFile);
    final results = AssignmentList.fromJson(data).assignments;
    _assignmentController.sink.add(results);
  }

  @override
  void dispose() {
    _assignmentController.close();
  }
}
