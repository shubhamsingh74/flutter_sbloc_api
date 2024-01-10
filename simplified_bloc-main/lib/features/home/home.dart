import 'package:flutter/material.dart';
import 'package:flutter_bloc_sample/features/counter1/counter1.dart';
import 'package:flutter_bloc_sample/features/counter2/counter2.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bloc Test"),
        ),
        body: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Counter1(), Counter2()]));
  }
}
