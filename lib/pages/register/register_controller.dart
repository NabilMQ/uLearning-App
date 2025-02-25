import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/pages/register/bloc/register_bloc.dart';

class RegisterController {
  final BuildContext context;
  const RegisterController({
    required this.context,
  });

  void handleRegister() async {
    final state = context.read<RegisterBloc>().state;
    String username = state.username;
    String email = state.email;
    String password = state.password;
    String rePassword = state.rePassword;

    if (username.isEmpty) {
      toastInfo(
        msg: "Username can't be empty"
      );
      return;
    }
    if (email.isEmpty) {
      toastInfo(
        msg: "Email can't be empty"
      );
      return;
    }
    if (password.isEmpty) {
      toastInfo(
        msg: "Password can't be empty"
      );
      return;
    }
    if (rePassword.isEmpty) {
      toastInfo(
        msg: "Password can't be empty"
      );
      return;
    }

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(username);
        String photoUrl = "https://vqcahlwszhdotxmtcfvp.supabase.co/storage/v1/object/public/ulearning//default.png";
        await credential.user?.updatePhotoURL(photoUrl);
        toastInfo(
          msg: "An email has been sent to your registered email. Activate the email by check your email box and click on the verification link",
        );

        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }


    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        toastInfo(
          msg: "Password is too weak",
        );
        return;
      }
      if (e.code == 'email-already-in-use') {
        toastInfo(
          msg: "The email is already in use",
        );
        return;
      }
      if (e.code == 'invalid-email') {
        toastInfo(
          msg: "The email is invalid",
        );
        return;
      }
    }
  }
}