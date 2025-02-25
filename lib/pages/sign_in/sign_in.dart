import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_events.dart';
import 'package:ulearning_app/pages/sign_in/sign_in_controller.dart';
import 'package:ulearning_app/pages/common_widgets.dart';

import 'package:ulearning_app/pages/sign_in/bloc/sign_in_blocs.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_states.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  @override
  void initState() {
    context.read<SignInBloc>().add(ClearBloc());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder <SignInBloc, SignInState> (
      builder: (context, state) {
        return Container(
          color: AppColors.primaryBackground,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.primaryBackground,
              appBar: buildAppBar("Log In"),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildThirdPartyLogin(context),
                    Center(
                      child: reusableText("Or use your email account login"),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 36.h
                      ),
                      padding: EdgeInsets.only(
                        left: 25.w,
                        right: 25.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText("Email"),
                          SizedBox(height: 5.h),
                          buildTextField(
                            "Enter your email address", 
                            "email", 
                            "assets/icons/user.png",
                            (value) {
                              context.read<SignInBloc>().add(EmailEvent(value));
                            }
                          ),
                          
                          reusableText("Password"),
                          SizedBox(height: 5.h),
                          buildTextField("Enter your password", 
                            "password", 
                            "assets/icons/lock.png",
                            (value) {
                              context.read<SignInBloc>().add(PasswordEvent(value));
                            }
                          ),
                        ],
                      ),
                    ),
                    forgotPassword(),
                    buildLogInAndRegButton(
                      "Log In", 
                      "login",
                      () {
                        SignInController(context: context).handleSignIn("email");
                      }
                    ),
                    buildLogInAndRegButton(
                      "Sign Up", 
                      "register",
                      () {
                        Navigator.of(context).pushNamed("/register");
                      }
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}