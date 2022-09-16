import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/home/task.dart';
import 'package:new_project/login_page.dart';
import 'package:new_project/theme_consts.dart';

import '../drawer.dart';

var taskList = <Task>[];

final user = FirebaseAuth.instance.currentUser!;
String? displayName = user.email?.substring(0, 10);
var addController = TextEditingController();
var searchController = TextEditingController();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IndexCubit(),
      child: Scaffold(
        endDrawer: const MainDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              createSearchField(),
              SingleChildScrollView(
                  child: createMiddleColumn(const TaskCard())),
            ],
          ),
        ),
      ),
    );
  }
}

Center createSearchField() {
  return Center(
    child: SizedBox(
      width: 200,
      height: 30,
      child: TextField(
        // onChanged: searchItem,
        controller: searchController,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: ThemeColors.mainThemeColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: ThemeColors.mainThemeColor),
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: ThemeColors.mainThemeColor,
            )),
        style: const TextStyle(color: ThemeColors.mainThemeColor, fontSize: 20),
      ),
    ),
  );
}

class TaskCard extends StatefulWidget {
  const TaskCard({Key? key}) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  void enableAddTask() {
    setState(() {
      enable();
    });
  }

  void deleteTask() {
    for (final e in taskList) {
      if (e.isSelected) {
        taskList.remove(e);
        setState(() {
          deleteTask();
        });
      }
    }
  }

  void searchItem(String text) {
    final suggestions = taskList.where((element) {
      final name = element.taskName.toLowerCase();
      final input = text.toLowerCase();
      return name.contains(input);
    }).toList();

    setState(() => taskList = suggestions);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndexCubit, AddStates>(
      builder: (context, state) {
        return Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
              side: const BorderSide(color: ThemeColors.mainThemeColor)),
          color: ThemeColors.mainTextColor,
          child: Center(
              child: Column(
            children: [
              const SizedBox(height: 35),
              Text(
                'Welcome $displayName',
                style: const TextStyle(
                    fontSize: 25, color: ThemeColors.mainThemeColor),
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    color: ThemeColors.mainTextColor,
                    child: ListView.builder(
                        itemCount: taskList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 60,
                            width: 170,
                            child: Card(
                              color: ThemeColors.mainThemeColor,
                              child: ListTile(
                                  onTap: () {
                                    if (taskList[index].isSelected) {
                                      taskList[index].isSelected = false;
                                    } else {
                                      taskList[index].isSelected = true;
                                    }
                                    setState(() {});
                                  },
                                  leading: const Icon(
                                      Icons.arrow_circle_right_outlined,
                                      size: 24,
                                      color: ThemeColors.mainTextColor),
                                  title: Text(taskList[index].taskName,
                                      style: const TextStyle(
                                          color: ThemeColors.mainTextColor,
                                          fontSize: 16)),
                                  trailing: taskList[index].isSelected
                                      ? const Icon(Icons.check_box,
                                          color: ThemeColors.mainTextColor)
                                      : const Icon(
                                          Icons.check_box_outline_blank,
                                          color: ThemeColors.mainTextColor)),
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                          height: 100,
                          width: 280,
                          child: state.index == AddStates.enabled.index
                              ? createAddCard()
                              : null),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  createBottomButton(
                      context, const Icon(Icons.add), enableAddTask, 35),
                  SizedBox(width: taskList.isNotEmpty ? 20 : 0),
                  createBottomButton(context, const Icon(Icons.delete),
                      deleteTask, taskList.isNotEmpty ? 35 : 0),
                ],
              )
            ],
          )),
        );
      },
    );
  }

  late String name;
  Card createAddCard() {
    return Card(
      child: Row(
        children: [
          IconButton(
            onPressed: disable,
            icon: const Icon(Icons.close),
            iconSize: 16,
          ),
          Center(
            child: SizedBox(
              width: 200,
              height: 100,
              child: Center(
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      name = text;
                    });
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        taskList.add(Task(taskName: name));
                        disable();
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      color: ThemeColors.mainTextColor,
                    ),
                  )),
                  style: const TextStyle(
                      color: ThemeColors.mainTextColor, fontSize: 12),
                  controller: nameTextController,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void enable() {
    context.read<IndexCubit>().enableAdd();
  }

  void disable() {
    context.read<IndexCubit>().disableAdd();
  }

  SizedBox createBottomButton(
      BuildContext context, Icon icon, Function f, double size) {
    return SizedBox(
      height: size,
      width: size,
      child: FloatingActionButton(
        backgroundColor: ThemeColors.mainThemeColor,
        onPressed: () {
          f();
        },
        child: icon,
      ),
    );
  }
}

enum AddStates {
  enabled,
  disabled;
}

class IndexCubit extends Cubit<AddStates> {
  IndexCubit() : super(AddStates.disabled);

  void enableAdd() {
    emit(AddStates.enabled);
  }

  void disableAdd() {
    emit(AddStates.disabled);
  }
}
