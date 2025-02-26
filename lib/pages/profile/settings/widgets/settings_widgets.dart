import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ulearning_app/common/debug/debug.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/application/bloc/app_bloc.dart';
import 'package:ulearning_app/pages/application/bloc/app_events.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_bloc.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_events.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_blocs.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_events.dart';

AppBar buildSettingsAppBar() {
  return AppBar(
    title: Text(
      "Settings",
      style: TextStyle(
        color: AppColors.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
    ),
    scrolledUnderElevation: 0,
    automaticallyImplyLeading: false,
    centerTitle: true,
  );
}

Widget logOutButton(BuildContext context) {
  return Center(
    child: Container(
      width: 140.w,
      height: 50.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.w),
        boxShadow: [
          BoxShadow(
            color: AppColors.primarySecondaryBackground,
            spreadRadius: 4,
            blurRadius: 7,
            offset: Offset(0, 3)
          )
        ]
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15.w),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(15.w),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Confirm Log Out"),
                  content: Text("Are you sure want to Log Out?"),
                  actions: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15.w),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Text(
                            "Cancel"
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15.w),
                        onTap: () async {
                          try {
                            context.read<SignInBloc>().add((ClearBloc()));
                            context.read<AppBloc>().add((TriggerAppEvent(0)));
                            context.read<HomePageBloc>().add((HomePageDots(sliderIndex: 0)));
                            Global.storageService.remove(AppConstants.storageUserProfileKey);
                            Global.storageService.remove(AppConstants.storageUserTokenKey);
                            if (await GoogleSignIn().isSignedIn()) {
                              await GoogleSignIn().disconnect().onError(
                                (e, s) {
                                  debug("error $e");
                                  debug("error $s");
                                  return null;
                                }
                              );
                            }
                            await FirebaseAuth.instance.signOut().then((_) async {
                              if (context.mounted) {
                                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.signIn, (route) => false);
                              }
                            });
                          } catch (e) {
                            debug("Error $e");
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Text(
                            "Confirm",
                          ),
                        ),
                      ),
                    ),
                  ],
                );  
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 15.w,
            children: [
              SizedBox(
                width: 20.w,
                height: 20.w,
                child: Image.asset(
                  "assets/icons/log-out.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
          
              Text(
                "Log Out",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                  color: AppColors.primaryElement,
                  fontFamily: "Avenir",
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}