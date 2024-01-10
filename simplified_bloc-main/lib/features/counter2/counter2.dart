import 'package:flutter/material.dart';
import 'package:flutter_bloc_sample/features/counter1/counter1_bloc.dart';
import 'package:flutter_bloc_sample/features/counter2/counter2_bloc.dart';
import 'package:flutter_bloc_sample/simplified_bloc.dart';

class Counter2 extends StatefulWidget {
  const Counter2({Key? key}) : super(key: key);

  @override
  State<Counter2> createState() => _Counter2State();
}

class _Counter2State extends State<Counter2> {
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
            'You have pushed counter2 button this many times:',
          ),
          SimplifiedBlocBuilder(
              bloc: counter2Bloc,
              eventFilter: [
                Counter2Event.increment,
                Counter2Event.incrementing,
              ],
              builder: (BuildContext context, dynamic state) {
                Counter2Bloc bloc = state;
                if (bloc.state == Counter2Event.incrementing) {
                  return const CircularProgressIndicator();
                }
                return Text(
                  '${bloc.count}',
                );
              }),
          const Text(
            'You have pushed the counter2 button this many times:',
          ),
          SimplifiedBlocBuilder(
              bloc: counter2Bloc,
              eventFilter: [
                Counter2Event.increment,
                Counter2Event.incrementing,
              ],
              builder: (BuildContext context, dynamic state) {
                Counter2Bloc bloc = state;
                if (bloc.state == Counter2Event.incrementing) {
                  return const CircularProgressIndicator();
                }
                return Text(
                  '${bloc.count}',
                );
              }),
          const SizedBox(height: 20),
          SimplifiedBlocBuilder(
            bloc: counter2Bloc,
            builder: (BuildContext context, dynamic state) {
              Counter2Bloc bloc = state;
              return FloatingActionButton(
                onPressed: () {
                  if (bloc.state != Counter2Event.incrementing) {
                    counter2Bloc.incrementCounter();
                  }
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              );
            },
          ),
        ],
      ),
    );
  }
}
