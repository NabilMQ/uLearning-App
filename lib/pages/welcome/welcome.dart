import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_blocs.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_events.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_states.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBackground,
      child: Scaffold(
        body: BlocBuilder <WelcomeBloc, WelcomeStates>(
          builder: (context, state) {
            return  Container(
              margin: EdgeInsets.only(
                top: 34.h
    ,          ),
              width: 375.w,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  PageView(
                    controller: pageController,
                    onPageChanged: (index) {
                      state.page = index;
                      context.read<WelcomeBloc>().add(WelcomeEvents());
                      // BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvents());
                    },
                    children: [
                      _page(
                        1,
                        context,
                        "Next",
                        "First see Learning",
                        "Forget about a for of paper all knowledge in one learning",
                        "assets/images/reading.png"
                      ),
                      _page(
                        2,
                        context,
                        "Next",
                        "Connect with Everyone",
                        "Always keep in touch with your tutor & friend. Let's get connected",
                        "assets/images/boy.png"
                      ),
                      _page(
                        3,
                        context,
                        "Get Started",
                        "Always Fascinated Learning",
                        "Anywhere, anytime. The time is at our discretion, so study whenever you want",
                        "assets/images/man.png"
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 50.h,
                      ),
                      child: DotsIndicator(
                        position: state.page,
                        dotsCount: 3,
                        mainAxisAlignment: MainAxisAlignment.center,
                        decorator: DotsDecorator(
                          color: AppColors.primaryThirdElementText,
                          size: const Size.square(8.0),
                          activeColor: AppColors.primaryElement,
                          activeSize: const Size(18.0, 8.0),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        )
      ),
    );
  }

  Widget _page(
    int index,
    BuildContext context,
    String buttonName,
    String title,
    String subTitle,
    String imagePath,
  ) {
    return Column(     
      children: [
        SizedBox(
          width: 345.w,
          height: 345.w,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 24.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Container(
          width: 375.w,
          padding: EdgeInsets.only(
            left: 30.w,
            right: 30.w,
          ),
          child: Text(
            subTitle,
            style: TextStyle(
              color: AppColors.primarySecondaryElementText,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),

        Container(
          width: 325.w,
          height: 50.h,
          margin: EdgeInsets.only(
            top: 100.h,
            left: 25.w,
            right: 25.w
          ),
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: AppColors.primaryElement,
            child: InkWell(
              borderRadius: BorderRadius.circular(15.w),
              onTap: () {
                if (index < 3) {
                  pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.decelerate,
                  );
                }
                else {
                  Global.storageService.setBool(AppConstants.storageDeviceOpenFirstTime, true);
                  Navigator.of(context).pushNamedAndRemoveUntil("/signIn", (route) => false);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(
                        alpha: 0.1,
                      ),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1)
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    buttonName,
                    style: TextStyle(
                      color: AppColors.primaryBackground,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}