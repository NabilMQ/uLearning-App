import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ulearning_app/common/routes/routes.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/global.dart';
Future <void> main() async {
  await Global.init();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:  [...AppPages.allBlocProviders(context)],
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                centerTitle: true,
                elevation: 0,
                backgroundColor: AppColors.primaryBackground,
              )
            ),
            onGenerateRoute: AppPages.generateRouteSettings,
          );
        },
      ),
    );
  }
}