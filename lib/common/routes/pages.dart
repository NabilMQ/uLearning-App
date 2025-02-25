import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/global.dart';

import 'package:ulearning_app/pages/application/application_page.dart';
import 'package:ulearning_app/pages/application/bloc/app_bloc.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_bloc.dart';
import 'package:ulearning_app/pages/course/course_detail/course_detail.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_bloc.dart';
import 'package:ulearning_app/pages/home/home_page.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_bloc.dart';
import 'package:ulearning_app/pages/profile/settings/settings.dart';

import 'package:ulearning_app/pages/register/bloc/register_bloc.dart';
import 'package:ulearning_app/pages/register/register.dart';

import 'package:ulearning_app/pages/sign_in/bloc/sign_in_blocs.dart';
import 'package:ulearning_app/pages/sign_in/sign_in.dart';

import 'package:ulearning_app/pages/welcome/bloc/welcome_blocs.dart';
import 'package:ulearning_app/pages/welcome/welcome.dart';

class AppPages {
  static List <PageEntity> routes() { 
    return [
      PageEntity(
        route: AppRoutes.initial,
        page: const Welcome(),
        bloc: BlocProvider(
          create: (context) {
            return WelcomeBloc();
          },
        ),
      ),
      PageEntity(
        route: AppRoutes.signIn,
        page: const SignIn(),
        bloc: BlocProvider(
          create: (context) {
            return SignInBloc();
          },
        ),
      ),
      PageEntity(
        route: AppRoutes.register,
        page: const Register(),
        bloc: BlocProvider(
          create: (context) {
            return RegisterBloc();
          },
        ),
      ),
      PageEntity(
        route: AppRoutes.application,
        page: const ApplicationPage(),
        bloc: BlocProvider(
          create: (context) {
            return AppBloc();
          },
        )
      ),
      PageEntity(
        route: AppRoutes.application,
        page: const ApplicationPage(),
        bloc: BlocProvider(
          create: (context) {
            return AppBloc();
          },
        )
      ),
      PageEntity(
        route: AppRoutes.homePage,
        page: const HomePage(),
        bloc: BlocProvider(
          create: (context) {
            return HomePageBloc();
          },
        )
      ),
      PageEntity(
        route: AppRoutes.settings,
        page: const SettingsPage(),
        bloc: BlocProvider(
          create: (context) {
            return SettingsBloc();
          },
        )
      ),

      PageEntity(
        route: AppRoutes.courseDetail,
        page: CourseDetail(),
        bloc: BlocProvider(
          create: (context) {
            return CourseDetailBloc();
          },
        )
      ),
    ];
  }

  static List <dynamic> allBlocProviders (BuildContext context) {
    List <dynamic> blocProviders = <dynamic> [];
    for (var bloc in routes()) {
      if (bloc.bloc != null) {
        blocProviders.add(bloc.bloc);
      }
    }
    return blocProviders;
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {

        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
        if (result.first.route == AppRoutes.initial && deviceFirstOpen) {

          bool isLoggedIn = Global.storageService.getIsLoggedIn();
          if (isLoggedIn) {
            return MaterialPageRoute(
              builder: (context) {
                return ApplicationPage();
              },
            );
          }


          return MaterialPageRoute(
            builder: (context) {
              return SignIn();
            },
            settings: settings,
          );
        }

        return MaterialPageRoute(
          builder: (_) {
            return result.first.page;
          },
          settings: settings,
        );
      }
    }

    return MaterialPageRoute(
      builder: (_) {
        return SignIn();
      },
      settings: settings,
    );
  }
}


class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({
    required this.route,
    required this.page,
    this.bloc,
  });
}