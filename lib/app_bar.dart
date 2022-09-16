import 'package:flutter/material.dart';
import 'package:new_project/theme_consts.dart';

class MainAppBar extends AppBar {
  MainAppBar({Key? key})
      : super(
            key: key,
            flexibleSpace: const Padding(
              padding: EdgeInsets.only(top: 35),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Let's",
                    style: TextStyle(
                        color: ThemeColors.mainTextColor, fontSize: 30),
                  )),
            ),
            actions: [
              Builder(builder: (context) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: const Icon(Icons.settings));
              })
            ],
            title: const AppBarButton());
}

class AppBarButton extends StatelessWidget {
  const AppBarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Center(child: ThemeIcons.mainAppBarIcon),
    );
  }
}
