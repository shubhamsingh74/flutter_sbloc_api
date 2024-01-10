**Simplified Bloc**

### Key Concepts:

1. **Single Event Stream:**

   - SBloc utilizes a single event stream for all interactions.
   - This design choice simplifies the API and consolidates event handling.

2. **BlocEvent Enum:**
   - Developers define all events using the `BlocEvent` enum.
   - This centralizes and organizes event management within the package.

### How it Works:

1. **State Update:**

   - Inside `onEvent`, the bloc's state is updated to the received event.

   ```
   void onEvent(BlocEvent event) {
      state = event;
      for (var i = 0; i < blocs.length; i++) {
        if (!blocs[i].bloc.mounted) continue;
        if (blocs[i].eventFilters.isEmpty ||
            blocs[i].eventFilters.contains(event)) {
          debugPrint(
            "Bloc $i SetState() called for Event : ${event.name}!",
          );
          blocs[i].listener?.call(event);
          // ignore: invalid_use_of_protected_member
          blocs[i].bloc.setState(() {}); // This will rebuild client widgets
        }
      }
    }
   ```

2. **Widget Rebuilding:**

   - SBloc introduces fine-grained control over widget rebuilding using event filters.
   - Each widget wrapped in a `SimplifiedBlocBuilder` has an associated `eventFilter` list.
   - Widgets will only rebuild if the incoming event is in their `eventFilter` list.

3. **Performance Optimization:**

   - SBloc optimizes performance by selectively rebuilding only the affected widgets.
   - Developers gain precise control over which widgets respond to specific events, improving overall application efficiency.

4. **Widget Mount Check:**

   - SBloc checks if a widget is mounted before triggering a rebuild.
   - This prevents unnecessary rebuilds for widgets that may have been disposed or are not currently in view.

5. **Usage of `setState`:**
   - The use of `setState` within the `onEvent` method triggers the rebuilding of widgets.
   - This ensures that changes in state are reflected in the UI.

### Advantages Over Classic Bloc:

1. **Simplified API with Single Stream:**

   - SBloc significantly reduces the complexity of the bloc pattern by using a single event stream.
   - Developers have a unified interface for handling all events.

2. **BlocEvent Enum for Centralized Event Management:**

   - The `BlocEvent` enum centralizes event definitions, making it easy for developers to manage and understand all possible events in one place.

3. **Fine-Grained Control Over Widget Rebuilding:**

   - Developers can precisely control which widgets rebuild in response to specific events.
   - The `eventFilter` mechanism enhances modularity and maintainability.

4. **Performance Boost:**
   - Selective widget rebuilding enhances application performance by avoiding unnecessary updates.
   - Developers can optimize resource usage and improve the overall responsiveness of the app.

### How to use

1. **SimplifiedBlocBuilder**

   - The widget is constructed using SimplifiedBlocBuilder in response to state changes.
   - The builder function will be called many times and should return a widget in response to the state.

2. **Listner**
   - The purpose of this function is to perform functionality that needs to occur once per state change, such as navigation, displaying a snack bar, displaying a dialog, etc.

### Example

    **main.dart**
    ```
    Widget build(BuildContext context) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed counter button this many times:',
            ),
            SimplifiedBlocBuilder(
                bloc: counterBloc,
                eventFilter: [
                  CounterEvent.increment,
                  CounterEvent.incrementing,
                ],
                builder: (BuildContext context, dynamic state) {
                  CounterBloc bloc = state;
                  if (bloc.state == CounterEvent.incrementing) {
                    return const CircularProgressIndicator();
                  }
                  return Text(
                    '${bloc.count}',
                  );
                }),
            const SizedBox(height: 20),
            SimplifiedBlocBuilder(
              bloc: counterBloc,
              builder: (BuildContext context, dynamic state) {
                CounterBloc bloc = state;
                return FloatingActionButton(
                  onPressed: () {
                    if (bloc.state != CounterEvent.incrementing) {
                      counterBloc.incrementCounter();
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
    ```
    Here, the SimplifiedBlocBuilder is used to handle the re-building of the counter widget for the defined CounterEvents namely "{Increment, Incrementing}"

    **counterEvents.dart**
    ```
    class CounterEvent extends BlocEvent {
      static final increment = CounterEvent('Increment');
      static final incrementing = CounterEvent('Incrementing');
      CounterEvent(super.name);
    }
    ```

    **counterBloc.dart**
    ```
    class CounterBloc extends SimplifiedBloc {
    int count = 0;

    Future<void> incrementCounter() async {
      addEvent(CounterEvent.increment);
    }

    @override
    onEvent(BlocEvent event) async {
        if (event == CounterEvent.increment) {
          super.onState(CounterEvent.incrementing);
          await Future.delayed(const Duration(seconds: 1));
          count++;
          super.onState(CounterEvent.increment);
        }
        super.onEvent(event);
      }
    }
    ```
    When the user interacts with the counter widget (here increments the counter), a method incremmentCounter() is is called which adds an "CounterEvent.increment" BlocEvent to the SBloc. When this event is triggered the onEvent() method is called to process the logic and re-build the widget with appropriate response (here, increment the counter value 1).
