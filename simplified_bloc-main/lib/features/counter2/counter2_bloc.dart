import '../../simplified_bloc.dart';

class Counter2Event extends BlocEvent {
  static final increment = Counter2Event('Increment');
  static final incrementing = Counter2Event('Incrementing');
  Counter2Event(super.name);
}

class Counter2Bloc extends SimplifiedBloc {
  int count = 0;

  Future<void> incrementCounter() async {
    addEvent(Counter2Event.increment);
  }

  @override
  onEvent(BlocEvent event) async {
    if (event == Counter2Event.increment) {
      super.onState(Counter2Event.incrementing);
      await Future.delayed(const Duration(seconds: 1));
      count++;
      super.onState(Counter2Event.increment);
    }
    super.onEvent(event);
  }
}

final counter2Bloc = Counter2Bloc();
