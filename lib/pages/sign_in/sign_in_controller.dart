import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ulearning_app/common/apis/user_api.dart';
import 'package:ulearning_app/common/entities/user.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_blocs.dart';

class SignInController {

  final BuildContext context;

  const SignInController({
    required this.context,
  });

  void handleSignIn(String type) async {
    try {
      if (type == "email") {
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;
        if (emailAddress.isEmpty) {
          throw("Email is empty");
        } 

        if (password.isEmpty) {
          throw("Password is empty");
        } 

        try {
          final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailAddress,
              password: password,
          ).then((value) {
            toastInfo(
              msg: "Successfully logging in!",
            );
            return value;
          });


          if (credential.user  == null) {
            toastInfo(
              msg: "User does not exist",
            );
          }

          if (!credential.user!.emailVerified) {
            toastInfo(
              msg: "User email does not verified",
            );
          }

          var user = credential.user;
          if (user != null) {
            String? displayName = user.displayName;
            String? email = user.email;
            String? id = user.uid;
            String? photoUrl = user.photoURL;

            LoginRequestEntity loginRequestEntity = LoginRequestEntity();
            loginRequestEntity.avatar = photoUrl;
            loginRequestEntity.name = displayName;
            loginRequestEntity.email = email;
            loginRequestEntity.open_id = id;
            // type 1 means email login
            loginRequestEntity.type = 1;

            toastInfo(
              msg: "User exist",
            );

            asyncPostAllData(loginRequestEntity);
          }
          else {
            toastInfo(
              msg: "User does not exist",
            );
          }
        } 
        on FirebaseAuthException catch (e) {
          if (e.code == "user-not-found") {
            toastInfo(
              msg: "No user found for that email",
            );
          }
          else if (e.code == "wrong-password") {
            toastInfo(
              msg: "Wrong password",
            );
          }
          else if (e.code == "invalid-email") {
            toastInfo(
              msg: "Wrong email format",
            );
          }
          else {
            toastInfo(
              msg: "Something went wrong when signing in: $e",
            );
          }
        }   
      }
    }
    catch (e) {
      toastInfo(
        msg: "Something went wrong before signing in: $e",
      );
    }
  }


  void asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );

    try {
      var result = await UserAPI.login(
        params: loginRequestEntity,
      );

      if (result.code == 200) {
        try {
          Global.storageService.setString(AppConstants.storageUserProfileKey, jsonEncode(result.data!));
          Global.storageService.setString(AppConstants.storageUserTokenKey, result.data!.access_token!);
          EasyLoading.dismiss();
          if (context.mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil("/application", (route) => false);
          }
        }
        catch (e) {
          EasyLoading.dismiss();
          debugPrint("Error when saving to local storage: $e");
        }
      }
      else {
        EasyLoading.dismiss();
        toastInfo(msg: "Unknown Error $result");
      }
    }
    catch (e) {
        EasyLoading.dismiss();
        toastInfo(msg: "Unknown Error $e");
    }
  }
}