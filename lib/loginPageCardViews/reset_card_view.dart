import 'package:flutter/material.dart';
import 'package:new_project/theme_consts.dart';
import '../login_page.dart';
import 'package:new_project/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordCard extends StatelessWidget {
  const ResetPasswordCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 120,
          ),
          const Text('Reset Your Password ',
              style: TextStyle(color: ThemeColors.mainTextColor, fontSize: 15)),
          const SizedBox(
            height: 10,
          ),
          LoginPageTextField(
            prefixIcon: ThemeSignUpPage.emailIcon,
            controller: emailTextController,
            labelText: ThemeSignUpPage.emailText,
            maxChar: 50,
            obscureText: false,
            error: false,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 80,
            height: 40,
            child: InkWell(
              onTap: () {},
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: ThemeColors.mainTextColor)),
                child: const Center(
                  child: Text(
                    'Reset',
                    style: TextStyle(color: ThemeColors.mainTextColor),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Container(
            alignment: Alignment.topCenter,
            child: TextButton(
              onPressed: () {
                context.read<PageCubit>().setLogin();
              },
              child: const Text('Log In',
                  style: TextStyle(
                      color: ThemeColors.mainTextColor, fontSize: 11)),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: TextButton(
              onPressed: () {
                context.read<PageCubit>().setSignUp();
              },
              child: const Text('Sign Up',
                  style: TextStyle(
                      color: ThemeColors.mainTextColor, fontSize: 11)),
            ),
          ),
        ],
      )),
    );
  }
}
