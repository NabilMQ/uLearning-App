import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_events.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_states.dart';

class WelcomeBloc extends Bloc<WelcomeEvents, WelcomeStates> {
  WelcomeBloc() : super(WelcomeStates()) {
    on <WelcomeEvents> ((events, emit) {
      emit(WelcomeStates(page: state.page));
      // emit(WelcomeStates(counter: state.counter + 1));
    });
  }
}