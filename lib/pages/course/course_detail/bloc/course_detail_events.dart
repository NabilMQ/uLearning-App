import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/common/enum/enum.dart';

abstract class CourseDetailEvents {
  const CourseDetailEvents();
}

class TriggerCourseDetail extends CourseDetailEvents {
  TriggerCourseDetail({this.courseItem, this.state});

  final CourseItem? courseItem;
  final StateHandler? state;
}