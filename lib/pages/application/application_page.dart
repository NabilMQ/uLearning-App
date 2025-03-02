import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/application/widgets/application_widget.dart';
import 'package:ulearning_app/pages/application/bloc/app_bloc.dart';
import 'package:ulearning_app/pages/application/bloc/app_events.dart';
import 'package:ulearning_app/pages/application/bloc/app_states.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder <AppBloc, AppStates> (
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              body: buildPage(state.index),
              bottomNavigationBar: Container(
                width: 375.w,
                height: 58.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryElement,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.h),
                    topRight: Radius.circular(20.h),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(
                        alpha: 0.1,
                      ),
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  currentIndex: state.index,
                  elevation: 0,
                  selectedItemColor: AppColors.primaryElement,
                  backgroundColor: Colors.white,
                  unselectedItemColor: AppColors.primaryFourthElementText,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  onTap: (value) {
                    context.read<AppBloc>().add(TriggerAppEvent(value));
                  },
                  items: bottomTabs,
                ),
              ),
            ),
          ),  
        );
      },
    );
  }
}