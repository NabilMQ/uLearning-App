import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/apis/course_api.dart';
import 'package:ulearning_app/common/debug/debug.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/enum/enum.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_bloc.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_events.dart';

class HomeController {

  late  BuildContext context;

  HomeController({required this.context});

  UserItem get userProfile => Global.storageService.getUserProfile()!;

  Future <void> init() async {
    if (Global.storageService.getUserToken().isNotEmpty) {
      try {
        context.read<HomePageBloc>().add(
          HomePageCourseItem(
            state: StateHandler.loading,
          ),
        );
        CourseListResponseEntity result = await CourseAPI.courseList();
        if (result.code == 200) {
          if (context.mounted) {
            context.read<HomePageBloc>().add(
              HomePageCourseItem(
                courseItem: result.data!,
                state: StateHandler.success,
              ),
            );
          }
        }
        else {
          if (context.mounted) {
            context.read<HomePageBloc>().add(
              HomePageCourseItem(
                state: StateHandler.failure,
              ),
            );
          }
          debug(result.msg);
        }
      }
      catch (e) {
        if (context.mounted) {
          context.read<HomePageBloc>().add(
            HomePageCourseItem(
              state: StateHandler.failure,
            ),
          );
        }
        debug("Something went wrong: $e");
      }
      
    }
    else {
      debug("User has already logged out");
    }
  }
}