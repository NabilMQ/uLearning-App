import 'package:ulearning_app/common/entities/course.dart';

class HomePageStates {
  HomePageStates({
    this.sliderIndex = 0,
    this.filterIndex = 0,
    this.courseItem = const <CourseItem> [],
  });

  final int sliderIndex;
  final int filterIndex;
  final List <CourseItem> courseItem;

  HomePageStates copyWith({
    int? sliderIndex,
    int? filterIndex,
    List <CourseItem>? courseItem,
  }) {
    return HomePageStates(
      courseItem: courseItem ?? this.courseItem,
      sliderIndex: sliderIndex ?? this.sliderIndex,
      filterIndex: filterIndex ?? this.filterIndex,
    );
  }

}