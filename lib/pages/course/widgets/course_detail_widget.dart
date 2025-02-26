import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/common_widgets.dart';
import 'package:ulearning_app/pages/course/course_detail/course_detail_controller.dart';
import 'package:url_launcher/url_launcher.dart';

AppBar buildCourseDetailAppBar() {
  return AppBar(
    title: reusableText(
      "Course Detail",
      hasMargin: false,
    ),
    scrolledUnderElevation: 0,
  );
}

Widget thumbnail(String url) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15.w),
    child: SizedBox(
      width: 325.w,
      height: 200.h,
      child: Image.network(
        url,
        fit: BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress != null) {
            return CircularProgressIndicator(
              value: loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!,
            );
          }
          return child;
        },
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.error,
            color: Colors.red,
          );
        },
      ),
    ),
  );
}

Widget menuButton({
  required int downNum,
  required double score
}) {
  return SizedBox(
    width: 325.w,
    child: Row(
      spacing: 20.w,
      children: [
        ElevatedButton(
          onPressed: () {
            
          },
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 5.h,
              ),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.w),
              ),
            ),
            minimumSize: WidgetStatePropertyAll(
              Size(50.w, 25.h),
            ),
            backgroundColor: WidgetStatePropertyAll(
              AppColors.primaryElement
            ),
            overlayColor: WidgetStatePropertyAll(
              AppColors.primaryElement.withValues(
                red: AppColors.primaryElement.r * 2.2,
                green: AppColors.primaryElement.g * 2.2,
                blue: AppColors.primaryElement.b * 2.2,
              )
            ),
          ),
          child: reusableText(
            "Author Page",
            hasMargin: false,
            textStyle: TextStyle(
              color: AppColors.primaryElementText,
              fontSize: 11.sp,
            ),
          ),
        ),

        _iconWIthNumber('assets/icons/people.png', downNum),
        _iconWIthNumber('assets/icons/star.png', score),
      ],
    ),
  );
}


Widget _iconWIthNumber(String iconPath, num number) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    spacing: 8.w,
    children: [
      Image.asset(
        iconPath,
        width: 20.w,
        height: 20.w,
      ), 

      reusableText(
        number.toString(),
        hasMargin: false,
        textStyle:  TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.normal,
        )
      ),
    ],
  );
}

Widget goBuyButton({
  required CourseDetailController courseDetailController,
  required int courseId,
  required int userId, 
  required String courseName,
  required String userEmail,
  required double? amount,
  }) {
  return ElevatedButton(
    onPressed: () async {
      var url = await courseDetailController.goBuy(
        courseId,
        userId,
        courseName,
        userEmail,
        amount,
      );
      if (!await launchUrl(Uri.parse(url))) {
        throw Exception('Could not launch $url');
      }
    },
    style: ButtonStyle(
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 5.h,
        ),
      ),
      minimumSize: WidgetStatePropertyAll(
        Size(330.w, 50.h),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.w),
        ),
      ),
      backgroundColor: WidgetStatePropertyAll(
        AppColors.primaryElement
      ),
      overlayColor: WidgetStatePropertyAll(
        AppColors.primaryElement.withValues(
          red: AppColors.primaryElement.r * 2.2,
          green: AppColors.primaryElement.g * 2.2,
          blue: AppColors.primaryElement.b * 2.2,
        )
      ),
    ),
    child: reusableText(
      "Go Buy",
      hasMargin: false, 
      textStyle: TextStyle(
        color: AppColors.primaryElementText,
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
      )
    ),
  );
}

 Widget courseSummary({required Map <String, String> valueAndText}) {
  return Column(
    spacing: 6.h,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: List.generate(valueAndText.length, (index) {
      return SizedBox(
        height: 40.w,
        child: Row(
          spacing: 15.w,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.w),
              child: SizedBox(
                width: 30.w,
                height: 30.w,
                child: Image.asset(
                  valueAndText.values.elementAt(index),
                ),
              ),
            ),
            
            Text(
              valueAndText.keys.elementAt(index),
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      );
    }),
  );
 }

 Widget courseLessonList() {
  return Container(
    width: 325.w,
    height: 80.h,
    margin: EdgeInsets.only(
      bottom: 25.h,
    ),
    child: Stack(
      children: [
        Container(
          width: 325.w,
          height: 80.h,
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.circular(10.w),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(
                  alpha: 0.6,
                ),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),

          child: Row(
            spacing: 12.w,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  spacing: 12.w,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.h),
                      child: SizedBox(
                        width: 60.w,
                        height: 60.w,
                        child: Image.asset(
                          'assets/icons/image_1.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2.h,
                      children: [
                        Text( 
                          "UI Design",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text( 
                          "UI Design",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: AppColors.primaryThirdElementText,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Image.asset(
                "assets/icons/arrow_right.png",
                width: 24.h,
                height: 24.h,
              )
            ],
          ),
        ),
    
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.w),
          child: InkWell(
            onTap: () {
              
            },
            child: SizedBox.expand(),
          ),
        ),
      ],
    ),
  );
 }