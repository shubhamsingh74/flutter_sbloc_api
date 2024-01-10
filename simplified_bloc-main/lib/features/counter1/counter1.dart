import 'package:flutter/material.dart';
import 'package:flutter_bloc_sample/simplified_bloc.dart';
import 'package:flutter_bloc_sample/features/counter1/counter1_bloc.dart';

class Counter1 extends StatefulWidget {
  const Counter1({Key? key}) : super(key: key);

  @override
  State<Counter1> createState() => _Counter1State();
}

class _Counter1State extends State<Counter1> {
  @override
  void dispose() {
    counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed counter1 button this many times:',
          ),
          SimplifiedBlocBuilder(
              bloc: counterBloc,
              eventFilter: [
                Counter1Event.increment,
              ],
              builder: (BuildContext context, dynamic state) {
                Counter1Bloc bloc = state;
                return Text(
                  '${bloc.count}',
                );
              }),
          const Text(
            'You have pushed counter1 button this many times:',
          ),
          SimplifiedBlocBuilder(
              bloc: counterBloc,
              eventFilter: [
                Counter1Event.increment,
              ],
              builder: (BuildContext context, dynamic state) {
                Counter1Bloc bloc = state;
                return Text(
                  '${bloc.count}',
                );
              }),
          const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () {
              counterBloc.incrementCounter();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
