import 'package:class_room/BLOC/assignment_bloc.dart';
import 'package:class_room/BLOC/bloc_provider.dart';
import 'package:class_room/BLOC/chapter_bloc.dart';
import 'package:class_room/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChapterBloc>(
      bloc: ChapterBloc(),
      child: BlocProvider<AssignmentBloc>(
        bloc: AssignmentBloc(),
        child: MaterialApp(
          title: 'Class Room',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
