import 'package:flutter/material.dart';
import 'package:flutter_bloc_sample/features/home/home.dart';
import 'package:flutter_bloc_sample/simplified_dependencies.dart';

class MyApp extends StatelessWidget {
  final SimplifiedDependencies dependencies =
      SimplifiedDependencies(const [Home()]);
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homePage = SimplifiedDependencies.dependencies[Home];
    return MaterialApp(
        title: 'Flutter Bloc',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: homePage);
  }
}
