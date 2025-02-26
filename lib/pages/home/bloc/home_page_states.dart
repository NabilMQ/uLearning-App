import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/common/enum/enum.dart';

class HomePageStates {
  HomePageStates({
    this.sliderIndex = 0,
    this.filterIndex = 0,
    this.state,
    this.courseItem = const <CourseItem> [],
  });

  final int sliderIndex;
  final int filterIndex;
  final StateHandler? state;
  final List <CourseItem> courseItem;

  HomePageStates copyWith({
    int? sliderIndex,
    int? filterIndex,
    StateHandler? state,
    List <CourseItem>? courseItem,
  }) {
    return HomePageStates(
      courseItem: courseItem ?? this.courseItem,
      sliderIndex: sliderIndex ?? this.sliderIndex,
      state: state ?? this.state,
      filterIndex: filterIndex ?? this.filterIndex,
    );
  }

}