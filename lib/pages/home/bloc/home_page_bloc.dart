import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_events.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_states.dart';

class HomePageBloc extends Bloc <HomePageEvents, HomePageStates> {
  HomePageBloc() : super(HomePageStates()) {
    on <HomePageDots> (_homePageDots);
    on <HomePageFilter> (_homePageFilter);
    on <HomePageCourseItem> (_homePageCourseItem);
  }

  void _homePageDots(HomePageDots event, Emitter <HomePageStates> emit) {
    emit(
      state.copyWith(
        sliderIndex: event.sliderIndex,
      ),
    );
  }

  void _homePageFilter(HomePageFilter event, Emitter <HomePageStates> emit) {
    emit(
      state.copyWith(
        filterIndex: event.filterIndex,
      )
    );
  }
  
  void _homePageCourseItem(HomePageCourseItem event, Emitter <HomePageStates> emit) {
    emit(
      state.copyWith(
        courseItem: event.courseItem,
        state: event.state,
      )
    );
  }
}