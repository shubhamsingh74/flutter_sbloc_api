import 'package:flutter_sbloc_api/simplified_bloc.dart';

class ApiEvents extends BlocEvent {

  static final postInitialFetchEvent = ApiEvents('postInitialFetchEvent');
  static final postAddEvent = ApiEvents('postAddEvent');
  ApiEvents(super.name);
}