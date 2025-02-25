import 'package:ulearning_app/common/entities/course.dart';

abstract class HomePageEvents {
  const HomePageEvents();
}

class HomePageDots extends HomePageEvents {
  HomePageDots({required this.sliderIndex});

  final int sliderIndex;
}

class HomePageFilter extends HomePageEvents {
  HomePageFilter({ required this.filterIndex });
  
  final int filterIndex;
}

class HomePageCourseItem extends HomePageEvents {
  const HomePageCourseItem(this.courseItem);
  final List <CourseItem> courseItem;
}