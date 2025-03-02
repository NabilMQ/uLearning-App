
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ulearning_app/common/apis/course_api.dart';
import 'package:ulearning_app/common/debug/debug.dart';
import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/common/enum/enum.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_bloc.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_events.dart';

class CourseDetailController {
  final BuildContext context;

  CourseDetailController({
    required this.context,
  });



  Future <void> init() async {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    try {
      context.read<CourseDetailBloc>().add(TriggerCourseDetail(state: StateHandler.loading));
      CourseDetailResponseEntity result = await CourseAPI.courseDetail(id);
      if (result.code == 200) {
        if (context.mounted) {
          context.read<CourseDetailBloc>().add(TriggerCourseDetail(courseItem: result.data!, state: StateHandler.success));
        }
      }
    }
    catch (e) {
      if (context.mounted) {
        context.read<CourseDetailBloc>().add(TriggerCourseDetail(courseItem: null, state: StateHandler.failure));
      }
    }
  }

  Future <String> goBuy(int? id) async {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );

    CourseRequestEntity courseRequestEntity = CourseRequestEntity();
    courseRequestEntity.id = id;
    var result = await CourseAPI.coursePay(params: courseRequestEntity); 

    EasyLoading.dismiss();

    if (result.code == 200) {
      var url = Uri.decodeFull(result.data!);
      return url;
    }
    else {
      return "";
    }
  }
}