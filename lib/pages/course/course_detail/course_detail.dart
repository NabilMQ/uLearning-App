import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/enum/enum.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/common_widgets.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_bloc.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_states.dart';
import 'package:ulearning_app/pages/course/course_detail/course_detail_controller.dart';
import 'package:ulearning_app/pages/course/widgets/course_detail_widget.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({super.key});

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  late CourseDetailController _courseDetailController;
  GlobalKey _scaffoldKey = GlobalKey <ScaffoldState> ();

  @override
  void didChangeDependencies() async {
    _courseDetailController = CourseDetailController(context: context);
    await _courseDetailController.init();
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder <CourseDetailBloc, CourseDetailStates>(
      builder: (context, state) {
        if (state.state == StateHandler.failure) {
          return Container(
            color: Colors.white,
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.white,
              body: RefreshIndicator(
                onRefresh: () async {
                  setState(() async {
                    _scaffoldKey = GlobalKey <ScaffoldState> ();
                    await _courseDetailController.init();
                  });
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 12,
                      children: [
                        Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                    
                        Center(
                          child: Text(
                            "An error has occured",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        if (state.state == StateHandler.loading || state.state == StateHandler.idle) {
          return Container(
            color: Colors.white,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        return Container(
          color: Colors.white,
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            appBar: buildCourseDetailAppBar(),
            body: RefreshIndicator(
              onRefresh: () async {
                setState(() async {
                  _scaffoldKey = GlobalKey <ScaffoldState> ();
                  await _courseDetailController.init();
                });
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                  ),
                  child: Column(
                    spacing: 15.h,
                    children: [
                      thumbnail("${state.courseItem?.thumbnail!}"),
                      menuButton(
                        downNum: state.courseItem?.follow ?? 0,
                        score: state.courseItem?.score ?? 0,
                      ),
                        
                      Align(
                        alignment: Alignment.centerLeft,
                        child: reusableText(
                          "Course Description",
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: AppColors.primaryText,
                          ),
                          hasMargin: false,
                        ),
                      ),
                        
                      Transform.translate(
                        offset: Offset(0, -8.h),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: reusableText(
                            state.courseItem?.description ?? "No Description provided...",
                            textStyle: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.primaryThirdElementText,
                            ),
                            hasMargin: false,
                          ),
                        ),
                      ),
                        
                      goBuyButton(
                        courseDetailController: _courseDetailController,
                        courseId: state.courseItem?.id ?? -1,
                        courseName: state.courseItem?.name ?? "Best Course",
                        userId: -1,
                        userEmail: "nobody@gmail.com",
                        amount: double.parse(state.courseItem?.price ?? "1") * 16345,
                      ),
                        
                      Align(
                        alignment: Alignment.centerLeft,
                        child: reusableText(
                          "This Course Includes",
                          textStyle: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                        
                      Transform.translate(
                        offset: Offset(0, -8.h),
                        child: courseSummary(
                          valueAndText: {
                            state.courseItem?.video_len == null
                            ? "No Video Provided"
                              : state.courseItem!.video_len! > 1
                                ? "${state.courseItem?.video_len} Hours Video"
                                : "${state.courseItem?.video_len} Hour Video" 
                            : "assets/icons/video_detail.png",
                            
                            state.courseItem?.lesson_num == null
                              ? "No Lesson Provided"
                              : state.courseItem!.lesson_num! > 1
                                ? "Total ${state.courseItem?.lesson_num} Lessons"
                                : "Total ${state.courseItem?.lesson_num} Lesson" 
                            : "assets/icons/file_detail.png",
                            
                            state.courseItem?.video_len == null
                              ? "No Downloadable Resource"
                              : state.courseItem!.downloadable_resources! > 1
                                ? "${state.courseItem?.downloadable_resources} Downloadable Resources"
                                : "${state.courseItem?.downloadable_resources} Downloadable Resource" 
                            : "assets/icons/download_detail.png",
                          }
                        ),
                      ),
                      
                      Align(
                        alignment: Alignment.centerLeft,
                        child: reusableText(
                          "Lesson List",
                          textStyle: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                        
                      courseLessonList(),
                    ],
                  ),
                ),
              ),
            )
          ),
        );
      },
    );
  }
}