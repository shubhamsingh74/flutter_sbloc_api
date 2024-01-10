import 'package:flutter/material.dart';

import '../../simplified_bloc.dart';

class Counter1Event extends BlocEvent {
  static final increment = Counter1Event('Increment');
  Counter1Event(super.name);
}

class Counter1Bloc extends SimplifiedBloc {
  int count = 0;

  incrementCounter() {
    addEvent(Counter1Event.increment);
  }

  @override
  onEvent(BlocEvent event) {
    debugPrint('-----------> ${event.name}');
    if (event == Counter1Event.increment) {
      ++count;
      super.onState(Counter1Event.increment);
    }
    super.onEvent(event);
  }
}

final counterBloc = Counter1Bloc();
