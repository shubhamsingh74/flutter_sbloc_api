// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:flutter/material.dart';

class BlocData {
  BlocData({
    required this.bloc,
    required this.eventFilters,
    required this.stateFilters,
    required this.listener,
  });

  State bloc;
  List<BlocEvent> eventFilters;
  List<BlocEvent> stateFilters;
  void Function(BlocEvent)? listener;
}

abstract class SimplifiedBloc {
  static final StreamController<BlocEvent> _globalStreamController =
      StreamController<BlocEvent>();
  final StreamController<BlocEvent> _streamController =
      StreamController<BlocEvent>();

  Stream<BlocEvent> get stream => _streamController.stream;

  Stream<BlocEvent> get globalStream => _globalStreamController.stream;

  List<BlocData> blocs = [];
  BlocEvent state = BlocEvent.initial;
  static bool init = false;

  SimplifiedBloc() {
    listen();
  }

  void listen() {
    stream.listen((event) {
      debugPrint('local stream event: ${event.toString()}');
      onEvent(event);
    }, onError: (error) {
      debugPrint('Error in local stream : $error');
    });

    if (!init) {
      globalStream.listen((event) {
        debugPrint('global stream event: ${event.toString()}');
      }, onError: (error) {
        debugPrint('Error in local stream : $error');
      });
      init = true;
    }
  }

  void addEvent(BlocEvent event) {
    if (!_streamController.isClosed && !_globalStreamController.isClosed) {
      _streamController.sink.add(event);
      _globalStreamController.sink.add(event);
    }
  }

  void addGlobalEvent(BlocEvent event) {
    if (!_globalStreamController.isClosed) {
      _globalStreamController.sink.add(event);
    }
  }

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

  void onState(BlocEvent state) {
    this.state = state;
    for (var i = 0; i < blocs.length; i++) {
      if (!blocs[i].bloc.mounted) continue;
      if (blocs[i].eventFilters.isEmpty ||
          blocs[i].eventFilters.contains(state)) {
        debugPrint(
          "Bloc $i SetState() called for Event : ${state.name}!",
        );
        blocs[i].listener?.call(state);
        // ignore: invalid_use_of_protected_member
        blocs[i].bloc.setState(() {}); // This will rebuild client widgets
      }
    }
  }

  void dispose() {
    _streamController.close();
  }
}

class SimplifiedBlocBuilder<T extends SimplifiedBloc> extends StatefulWidget {
  final T bloc;
  final List<BlocEvent> eventFilter;
  final List<BlocEvent> stateFilter;
  final Widget Function(BuildContext, T)? builder;
  final void Function(BuildContext, T)? listener;
  final Widget? child;

  const SimplifiedBlocBuilder({
    Key? key,
    required this.bloc,
    this.builder,
    this.listener,
    this.child,
    this.eventFilter = const [],
    this.stateFilter = const [],
  }) : super(key: key);

  @override
  State<SimplifiedBlocBuilder<T>> createState() =>
      _SimplifiedBlocBuilderState();
}

class _SimplifiedBlocBuilderState<T extends SimplifiedBloc>
    extends State<SimplifiedBlocBuilder<T>> {
  late BlocData bloc;

  @override
  void initState() {
    bloc = BlocData(
      bloc: this,
      eventFilters: widget.eventFilter,
      stateFilters: widget.stateFilter,
      listener: widget.listener == null ? null : _onStateChange,
    );
    widget.bloc.blocs.add(bloc);
    super.initState();
  }

  void _onStateChange(BlocEvent event) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.listener?.call(context, widget.bloc);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder?.call(context, widget.bloc) ??
        widget.child ??
        const SizedBox();
  }

  @override
  void dispose() {
    widget.bloc.blocs.remove(bloc);
    super.dispose();
  }
}

class BlocEvent {
  static final initial = BlocEvent('Initial');
  static final loading = BlocEvent('Loading');
  static final loaded = BlocEvent('Loaded');
  static final error = BlocEvent('Error');

  final String name;

  BlocEvent(this.name);
}
