import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/apis/course_api.dart';
import 'package:ulearning_app/common/debug/debug.dart';
import 'package:ulearning_app/common/entities/entities.dart';
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
        CourseListResponseEntity result = await CourseAPI.courseList();
        if (result.code == 200) {
          if (context.mounted) {
            context.read<HomePageBloc>().add(HomePageCourseItem(result.data!));
          }
        }
        else {
          debug(result.msg);
        }
      }
      catch (e) {
        debug("Something went wrong: $e");
      }
      
    }
    else {
      debug("User has already logged out");
    }
  }
}