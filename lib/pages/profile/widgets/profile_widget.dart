import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/global.dart';

AppBar buildProfileAppBar() {
  return AppBar(
    scrolledUnderElevation: 0,
    title: Row(
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
    
        Text(
        "Profile",
        style: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
      ),
    
        Transform.translate(
          offset: Offset(5.w, 0),
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
                  "assets/icons/more-vertical.png",
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget profileIconAndEditButton() {
  return SizedBox(
    width: 80.w,
    height: 80.w,
    child: Stack(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(9999),
            onTap: () {},
            child: Container(
              width: 80.w,
              height: 80.w,
              padding: EdgeInsets.all(16.w),
              child: Image.network(
                Global.storageService.getUserProfile()!.avatar.toString(),
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
              
                  return child;
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 30.w,
                  );
                },
              ),
            ),
          ),
        ),
    
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(
              right: 6.w,
              bottom: 6.w,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.w),
              child: Material(
                borderRadius: BorderRadius.circular(20.w),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.w),
                  onTap: () {
                        
                  },
                  child: Container(
                    width: 25.w,
                    height: 25.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    child: Ink.image(
                      image: AssetImage(
                        "assets/icons/edit_3.png",
                      ),
                    ),
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

Map <String, String> imagesInfo = {
  "Settings": "assets/icons/settings.png",
  "Payment Details": "assets/icons/credit-card.png",
  "Achievement": "assets/icons/award.png",
  "Love": "assets/icons/heart(1).png",
  "Learning Reminders": "assets/icons/cube.png",
};

Widget buildListViewVertical(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(
      left: 15.w,
      right: 15.w,
      top: 20.h,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(imagesInfo.length, (index) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10.w),
            onTap: () {
              if (imagesInfo.keys.elementAt(index) == "Settings") {
                Navigator.of(context).pushNamed(AppRoutes.settings);
              }
            },
            child: Container(
              height: 40.w,
              margin: EdgeInsets.all(10.w),
              child: Row(
                spacing: 15.w,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    padding: EdgeInsets.all(7.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: AppColors.primaryElement,
                    ),
                    child: Image.asset(
                      imagesInfo.values.elementAt(index),
                    ),
                  ),
                  
                  Text(
                    imagesInfo.keys.elementAt(index),
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ),
  );
}