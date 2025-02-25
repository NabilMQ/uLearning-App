import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/course/bloc/course_events.dart';
import 'package:ulearning_app/pages/course/bloc/course_states.dart';
class CourseBloc extends Bloc <CourseEvents, CourseStates> {
  CourseBloc() : super(CourseStates()) {
    on <TriggerCourse> (_triggerCourse);
  }

  void _triggerCourse(TriggerCourse event, Emitter <CourseStates> emit) {
    emit(state.copyWith(
      courseItem: event.courseItem,
    ));
  }
}