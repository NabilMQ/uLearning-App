import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ulearning_app/common/debug/debug.dart';

import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/sign_in/sign_in_controller.dart';

AppBar buildAppBar(String title) {
  return AppBar(
    // bottom: PreferredSize(
    //   preferredSize: Size.fromHeight(1.0),

    //   child: Container(
    //     color: Colors.grey.withValues(
    //       alpha: 1.0,
    //     ),
    //     height: 1.0 ,
    //   ),
    // ),
    automaticallyImplyLeading: false,
    title: Text(
      title,
      style: TextStyle(
        color: AppColors.primaryText,
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
} 

Widget buildThirdPartyLogin(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
      top: 40.h,
      bottom: 20.h, 
    ),
    padding: EdgeInsets.only(
      left: 50.w,
      right: 50.w,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _reusableIcons(
          iconPath: "assets/icons/google.png",
          func: () {
            SignInController(context: context).handleSignIn("google");
          }),

        _reusableIcons(iconPath: "assets/icons/apple.png"),

        _reusableIcons(iconPath: "assets/icons/facebook.png"),
      ],
    )
  );
} 

Widget _reusableIcons({
  required String iconPath,
  Function? func
}) {
  return SizedBox(
    width: 40.w,
    height: 40.w,
    child: Ink.image(
      image: AssetImage(
        iconPath,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(9999),
        onTap: () async {
          if (func != null) {
            await func();
          }
        },
      ),
    ),
  );
}

Widget reusableText(
  String text, {
    Color color = AppColors.primarySecondaryElementText, 
    bool hasMargin = true, 
    TextStyle? textStyle, 
    }
  ) {
  return Container(
    margin: hasMargin ? EdgeInsets.only(
      bottom: 5.h,
    ) : EdgeInsets.zero,
    child: Text(
      text,
      style: textStyle ??  TextStyle(
        color: color,
        fontWeight: FontWeight.normal,
        fontSize: 14.sp,
      ),
    ),
  );
}

Widget buildTextField(String hintText, String textType, String iconPath, void Function(String value) func) { 

  return Container(
    width: 325.w,
    height: 50.h,
    margin: EdgeInsets.only(
      bottom: 20.h,
    ),
    decoration: BoxDecoration(
      color: AppColors.primaryBackground,
      borderRadius: BorderRadius.circular(15.w),
      border: Border.all(
        color: AppColors.primaryFourthElementText,
      )
    ),
    child: Row(
      children: [
        Container(
          width: 16.w,
          height: 16.w,
          margin: EdgeInsets.only(
            left: 17.w              
          ),
          child: Image.asset(
            iconPath,
          ),
        ),
        SizedBox  (
          width: 270.w,
          height: 50.h,
          child: TextField(
            onChanged: (value) => func(value),
            keyboardType: textType == "email"
              ? TextInputType.emailAddress
              : TextInputType.text,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),

              hintStyle: TextStyle(
                color: AppColors.primarySecondaryElementText,
              ), 
            ),
            autocorrect: false,
            obscureText: textType == "password" ? true : false,
            style: TextStyle( 
              color: AppColors.primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    )
  );
}

Widget forgotPassword() {
  return Container(
    width: 260.w,
    height: 44.h,
    margin: EdgeInsets.only(
      left: 25.w,
      bottom: 70.h,
    ),
    child: GestureDetector(
      onTap: () {
      },
      child: Text(
        "Forgot password",
        style: TextStyle(
          color: AppColors.primaryText,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.primaryText,
        ),
      ),
    ),
  );
}

Widget buildLogInAndRegButton(
  String buttonName,
  String buttonType,
  void Function() func,
) {
  return Container(
    width: 325.w,
    height: 50.h,
    margin: EdgeInsets.only(
      left: 25.w,
      right: 25.w,
      top: buttonType == "login"
        ? 40.h
        : 20.h,
    ),
    decoration: BoxDecoration(
      color: buttonType == "login" 
        ? AppColors.primaryElement
        : AppColors.primaryBackground,
      border: Border.all(
        color: buttonType == "login"
          ? Colors.transparent
          : AppColors.primaryFourthElementText,
      ),
      borderRadius: BorderRadius.circular(15.w),
      boxShadow: [
        BoxShadow(
          spreadRadius: 1,
          blurRadius: 2,
          offset: Offset(0, 1),
          color: Colors.grey.withValues(
            alpha: 0.1,
          ),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15.w),
        onTap: () {
          func();
        },
        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: buttonType == "login"
                ? AppColors.primaryBackground
                : AppColors.primaryText,
            ),
          ),
        ),
      ),
    ),
  );
}