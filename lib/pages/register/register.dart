import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/common_widgets.dart';
import 'package:ulearning_app/pages/register/bloc/register_bloc.dart';
import 'package:ulearning_app/pages/register/bloc/register_events.dart';
import 'package:ulearning_app/pages/register/bloc/register_states.dart';
import 'package:ulearning_app/pages/register/register_controller.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder <RegisterBloc, RegisterStates> (
      builder: (context, state) {
        return Container(
          color: AppColors.primaryBackground,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.primaryBackground,
              appBar: buildAppBar("Sign Up"),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20.h,
                      ),
                      child: Center(
                        child: reusableText("Enter your details below & free sign up"),
                      ),
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
                          reusableText("Username"),
                          SizedBox(height: 5.h),
                          buildTextField(
                            "Enter your username", 
                            "name", 
                            "assets/icons/user.png",
                            (value) {
                              context.read<RegisterBloc>().add(UsernameEvent(value));
                            }
                          ),

                          reusableText("Email"),
                          SizedBox(height: 5.h),
                          buildTextField(
                            "Enter your email address", 
                            "email", 
                            "assets/icons/user.png",
                            (value) {
                              context.read<RegisterBloc>().add(EmailEvent(value));
                            }
                          ),
                          
                          reusableText("Password"),
                          SizedBox(height: 5.h),
                          buildTextField("Enter your password", 
                            "password", 
                            "assets/icons/lock.png",
                            (value) {
                              context.read<RegisterBloc>().add(PasswordEvent(value));
                            }
                          ),

                          reusableText("Re-enter Password"),
                          SizedBox(height: 5.h),
                          buildTextField("Re-enter your password to confirm", 
                            "password", 
                            "assets/icons/lock.png",
                            (value) {
                              context.read<RegisterBloc>().add(RePasswordEvent(value));
                            }
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 25.w,
                      ),
                      child: reusableText("Enter your details below & free sign up"),
                    ),

                    buildLogInAndRegButton(
                      "Sign Up", 
                      "login",
                      () {
                        RegisterController(
                          context: context,
                        ).handleRegister();
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