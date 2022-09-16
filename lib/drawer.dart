import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/theme_consts.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.only(top: 40),
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Scaffold.of(context).closeEndDrawer();
                  },
                  icon: ThemeIcons.draverClosingIcons)),
          Container(
              padding: const EdgeInsets.only(top: 40),
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    Scaffold.of(context).closeEndDrawer();
                    FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(Icons.logout_rounded))),
        ],
      ),
    );
  }
}
