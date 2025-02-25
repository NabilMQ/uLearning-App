import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/application/bloc/app_events.dart';
import 'package:ulearning_app/pages/application/bloc/app_states.dart';

class AppBloc extends Bloc<AppEvents, AppStates> {
  AppBloc() : super(const AppStates()) {
    on <TriggerAppEvent> ((event, emit) {
      emit(AppStates(index: event.index));
    });
  }
}