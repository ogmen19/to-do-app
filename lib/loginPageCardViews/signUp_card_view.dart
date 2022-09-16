import 'package:flutter/material.dart';
import 'package:new_project/theme_consts.dart';
import 'package:new_project/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../login_page.dart';

class SignUpPageCard extends StatelessWidget {
  const SignUpPageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            LoginPageTextField(
              prefixIcon: ThemeLoginPageIcons.nameIcon,
              controller: nameTextController,
              labelText: ThemeLoginPageTexts.nameText,
              maxChar: 20,
              obscureText: false,
              error: false,
            ),
            const SizedBox(
              height: 20,
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
            LoginPageTextField(
              prefixIcon: ThemeLoginPageIcons.passwordIcon,
              controller: passwordTextController,
              labelText: ThemeLoginPageTexts.passwordText,
              maxChar: 10,
              obscureText: true,
              error: true,
              eye: true,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 10,
              padding: const EdgeInsets.only(right: 50),
              child: const Text(
                '! password must only include numbers',
                style: TextStyle(
                  color: ThemeColors.mainTextColor,
                  fontSize: 9,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: InkWell(
                onTap: (){},
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: ThemeColors.mainTextColor)),
                  child: const Center(
                    child: Text(
                      'Sign Up',
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
                "already have an account ?",
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
                  context.read<PageCubit>().setLogin();
                },
                child: const Text('Log In',
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
