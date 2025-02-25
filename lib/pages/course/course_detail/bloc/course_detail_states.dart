import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/common/enum/enum.dart';

class CourseDetailStates {
  CourseDetailStates({
    this.courseItem,
    this.state,
  });

  final CourseItem? courseItem;
  final StateHandler? state;

  CourseDetailStates copyWith({
    CourseItem? courseItem,
    StateHandler? state,
  }) {
    return CourseDetailStates(
      courseItem: courseItem ?? this.courseItem,
      state: state ?? this.state,
    );
  }

}