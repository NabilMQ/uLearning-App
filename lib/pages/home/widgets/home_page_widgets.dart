import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/common/routes/routes.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_bloc.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_events.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_states.dart';
import 'package:ulearning_app/pages/home/home_controller.dart';

AppBar buildHomePageAppBar(HomeController homeController) {
  return AppBar(
    scrolledUnderElevation: 0,
    title: Container(
      margin: EdgeInsets.only(
        right: 8.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.translate(
            offset: Offset(-5.w, 0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(9999),
                onTap: () {},
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  padding: EdgeInsets.all(11.w),
                  child: Image.asset(
                    "assets/icons/menu.png",
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(10.w, 0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(9999),
                onTap: () {},
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  padding: EdgeInsets.all(8.w),
                  child: Image.network(
                    homeController.userProfile.avatar!,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return CircularProgressIndicator(
                          value: loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!,
                        );
                      }
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.w),
                        child: child
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.error,
                        color: Colors.red,
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget homePageText(
  String text, {
  Color? color = AppColors.primaryText,
  double? topMargin,
}) {
  return Container(
    margin: EdgeInsets.only(
      top: topMargin ?? 5.h,
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget searchView() {
  return Padding(
    padding: EdgeInsets.only(
      top: 15.h,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 5,
      children: [
        Container(
          width: 280.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.circular(15.h),
            border: Border.all(color: AppColors.primaryFourthElementText),
          ),
          child: Row(
            children: [
              Container(
                width: 16.w,
                height: 16.w,
                margin: EdgeInsets.only(
                  left: 17.w,
                ),
                child: Image.asset(
                  "assets/icons/search.png",
                ),
              ),
              SizedBox(
                width: 240.w,
                height: 40.h,
                child: TextField(
                  onChanged: (value) {},
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                    hintText: "Search your course",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    hintStyle: TextStyle(
                      color: AppColors.primarySecondaryElementText,
                    ),
                  ),
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                  autocorrect: false,
                ),
              )
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(13.w),
          child: Material(
            color: AppColors.primaryElement,
            child: InkWell(
              borderRadius: BorderRadius.circular(13.w),
              onTap: () {},
              child: Container(
                width: 40.w,
                height: 40.w,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13.w),
                ),
                child: Ink.image(
                  image: AssetImage(
                    "assets/icons/options.png",
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget slidersView({
  required HomePageStates state,
  required BuildContext context,
}) {
  return Column(
    children: [
      Container(
          width: 325.w,
          height: 160.h,
          margin: EdgeInsets.only(
            top: 20.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.h),
          ),
          child: PageView(
            children: [
              _slidersContainer(path: "assets/icons/art.png"),
              _slidersContainer(path: "assets/icons/image_1.png"),
              _slidersContainer(path: "assets/icons/image_2.png"),
            ],
            onPageChanged: (value) {
              context.read<HomePageBloc>().add(HomePageDots(sliderIndex: value));
              // BlocProvider.of<HomePageBloc>(context).add(HomePageDots(index: value));
            },
          )),
      DotsIndicator(
        dotsCount: 3,
        position: state.sliderIndex,
        decorator: DotsDecorator(
          color: AppColors.primaryThirdElementText,
          activeColor: AppColors.primaryElement,
          size: const Size.square(5),
          activeSize: const Size(17.0, 5.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      )
    ],
  );
}

Widget _slidersContainer({String path = "assets/icons/art.png"}) {
  return Container(
    width: 325.w,
    height: 160.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.h),
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(
          path,
        ),
      ),
    ),
  );
}

Widget menuView({
  required HomePageStates state,
  required BuildContext context,
}) {
  return Column(
    children: [
      Container(
        width: 325.w,
        margin: EdgeInsets.only(
          top: 5.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _reusableSubTitleText(
              text: "Choose your course",
            ),
            Transform.translate(
              offset: Offset(10.w, 5.w),
              child: Material(
                borderRadius: BorderRadius.circular(9999),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(9999),
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: _reusableSubTitleText(
                      text: "See All",
                      color: AppColors.primaryThirdElementText,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(
          top: 20.w,
        ),
        child: Row(
          children: [
            _reusableMenuText(
              text: "All",
              fontWeight: FontWeight.normal,
              fontSize: 11,
              index: 0,
              indexNow: state.filterIndex,
              context: context,
            ),
            _reusableMenuText(
              text: "Popular",
              fontWeight: FontWeight.normal,
              fontSize: 11,
              index: 1,
              indexNow: state.filterIndex,
              context: context,
            ),
            _reusableMenuText(
              text: "Newest",
              fontWeight: FontWeight.normal,
              fontSize: 11,
              index: 2,
              indexNow: state.filterIndex,
              context: context,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _reusableMenuText({
  required String text,
  double? fontSize,
  FontWeight fontWeight = FontWeight.bold,
  required int index,
  required int indexNow,
  required BuildContext context,
}) {

  return Padding(
    padding: EdgeInsets.only(
      right: 10.w,
    ),
    child: Material(
      color: index == indexNow
        ? AppColors.primaryElement
        : Colors.white,
      borderRadius: BorderRadius.circular(7.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(7.w),
        onTap: () {
          context.read<HomePageBloc>().add(HomePageFilter(filterIndex: index));
        },
        child: Container(
          padding: EdgeInsets.only(
            left: 15.w,
            right: 15.w,
            top: 5.w,
            bottom: 5.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.w),
            border: index == indexNow
              ? Border.all(
                color: AppColors.primaryElement,
              )
              : Border.all(
                color: AppColors.primaryThirdElementText,
              ),
          ),
          child: _reusableSubTitleText(
            text: text,
            color: index == indexNow
              ?  AppColors.primaryElementText
              : AppColors.primaryThirdElementText,
            fontSize: fontSize,
            fontWeight: fontWeight,
          )
        ),
      ),
    ),
  );
}

Widget _reusableSubTitleText({
  required String text,
  Color color = AppColors.primaryText,
  double? fontSize,
  FontWeight fontWeight = FontWeight.bold,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize ?? 16.sp,
    ),
  );
}

Widget courseGrid({
  required CourseItem state,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15.w),
    child: Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.w),
      ),
      child: Image.network(
        "${state.thumbnail}",
        fit: BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress != null) {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
              ),
            );
          }
          
          return Stack(
            children: [
              SizedBox.expand(
                child: child
              ),
              SizedBox.expand(
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,  
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.name.toString(),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.primaryElementText,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 5.h,
                        ),
                        child: Text(
                          state.description.toString(),
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.primaryFourthElementText,
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
              SizedBox.expand(
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15.w),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.courseDetail,
                        arguments: state.id,
                      );
                    },
                  ),
                ),
              )
            ],
          );
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