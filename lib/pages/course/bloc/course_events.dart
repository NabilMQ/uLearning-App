import 'package:ulearning_app/common/entities/course.dart';

abstract class CourseEvents {
  const CourseEvents();
}

class TriggerCourse extends CourseEvents {
  TriggerCourse({required this.courseItem});

  final CourseItem courseItem;
}