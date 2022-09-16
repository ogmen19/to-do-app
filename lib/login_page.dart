import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/app_bar.dart';
import 'package:new_project/drawer.dart';
import 'package:new_project/home/home_page.dart';
import 'package:new_project/loginPageCardViews/reset_card_view.dart';
import 'package:new_project/main.dart';
import 'package:new_project/theme_consts.dart';
import 'loginPageCardViews/logIn_card_view.dart';
import 'loginPageCardViews/signUp_card_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageCubit(),
      child: const SingInPage(),
    );
  }
}

class SingInPage extends StatelessWidget {
  const SingInPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      endDrawer: const MainDrawer(),
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return createCircleIndicator();
            } else if (snapshot.hasError) {
              return const Center(child: Text(' Error!!'));
            } else if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const SingleChildScrollView(child: MainBodyColumn());
            }
          }),
    );
  }
}

var nameTextController = TextEditingController();
var passwordTextController = TextEditingController();
var emailTextController = TextEditingController();
bool isANumber = true;

class MainBodyColumn extends StatelessWidget {
  const MainBodyColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardValue = context
        .select<PageCubit, LogSignEnums>((PageCubit cubit) => cubit.state);

    late final StatelessWidget newCard;

    switch (cardValue) {
      case LogSignEnums.login:
        newCard = const LoginPageCard();
        break;
      case LogSignEnums.signup:
        newCard = const SignUpPageCard();
        break;
      case LogSignEnums.reset:
        newCard = const ResetPasswordCard();
        break;
    }

    return createMiddleColumn(newCard);
  }
}

Column createMiddleColumn(Widget newCard) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 50),
      Center(
        child: SizedBox(width: 300, height: 440, child: newCard),
      )
    ],
  );
}

// ignore: must_be_immutable
class LoginPageTextField extends StatefulWidget {
  LoginPageTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.obscureText,
    required this.error,
    required this.maxChar,
    this.eye = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final Icon prefixIcon;
  final bool error;
  final bool eye;
  final int maxChar;
  bool obscureText;
  @override
  State<LoginPageTextField> createState() => _LoginPageTextFieldState();
}

class _LoginPageTextFieldState extends State<LoginPageTextField> {
  RegExp digitValidator = RegExp("[0-9]+");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: TextField(
          onChanged: checkIfContaines,
          maxLength: widget.maxChar,
          obscureText: widget.obscureText,
          obscuringCharacter: '*',
          style:
              const TextStyle(color: ThemeColors.mainTextColor, fontSize: 12),
          decoration: InputDecoration(
            suffixIcon: widget.eye && passwordTextController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.obscureText = !widget.obscureText;
                      });
                    },
                    icon: Icon(
                      widget.obscureText
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 16,
                      color: ThemeColors.mainTextColor,
                    ),
                  )
                : null,
            errorText: widget.error
                ? isANumber
                    ? null
                    : "Please enter a number !"
                : null,
            counterText: '',
            prefixIcon: widget.prefixIcon,
            labelText: widget.labelText,
          ),
          controller: widget.controller),
    );
  }

  void checkIfContaines(String text) {
    if (text.isEmpty || digitValidator.hasMatch(text)) {
      setValidator(true);
    } else {
      setValidator(false);
    }
  }

  void setValidator(bool valid) {
    setState(() {
      isANumber = valid;
    });
  }
}

enum LogSignEnums { login, signup, reset }

class PageCubit extends Cubit<LogSignEnums> {
  PageCubit() : super(LogSignEnums.signup);

  void setLogin() {
    const newSate = LogSignEnums.login;
    emit(newSate);
  }

  void setSignUp() {
    const newSate = LogSignEnums.signup;
    emit(newSate);
  }

  void setReset() {
    const newSate = LogSignEnums.reset;
    emit(newSate);
  }
}
