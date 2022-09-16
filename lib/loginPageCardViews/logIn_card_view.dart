import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/theme_consts.dart';
import '../login_page.dart';
import 'package:new_project/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';

class LoginPageCard extends StatelessWidget {
  const LoginPageCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future logIn() async {
      showDialog(
          context: context, builder: (context) => createCircleIndicator());
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailTextController.text.trim(),
            password: passwordTextController.text.trim());
      } on FirebaseAuthException catch (e) {
        // ignore: avoid_print
        print(e);
      }
      navigatorkey.currentState!.popUntil((route) => route.isFirst);
    }

    return Card(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 45,
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
              height: 40,
            ),
            LoginPageTextField(
              prefixIcon: ThemeLoginPageIcons.passwordIcon,
              controller: passwordTextController,
              labelText: ThemeLoginPageTexts.passwordText,
              maxChar: 10,
              obscureText: true,
              error: true,
              eye: true,
            ),
            Container(
              padding: const EdgeInsets.only(right: 130),
              child: TextButton(
                onPressed: () {
                  context.read<PageCubit>().setReset();
                },
                child: const Text('forgot password ?',
                    style: TextStyle(
                        color: ThemeColors.mainTextColor, fontSize: 9)),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: InkWell(
                onTap: logIn,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: ThemeColors.mainTextColor)),
                  child: const Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(color: ThemeColors.mainTextColor),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: const Text(
                "don't have an account ?",
                style: TextStyle(
                  color: ThemeColors.mainTextColor,
                  fontSize: 9,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () {
                  context.read<PageCubit>().setSignUp();
                },
                child: const Text('Sign In',
                    style: TextStyle(
                        color: ThemeColors.mainTextColor, fontSize: 11)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
