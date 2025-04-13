import 'package:flutter/material.dart';
import 'package:tasks_joddb/features/main/presentaion/screens/add_task_screen.dart';

import '../../presentaion/screens/home_screen.dart';
import '../../presentaion/screens/tasks_calender_screen.dart';
import 'main_routes.dart';

class MainNavigation {
  static Route? generateHomeRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainRoutes.HOME_SCREEN:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        var tasks = generateTasksRoute(settings);
        if (tasks != null) {
          return tasks;
        }
    }
    return MaterialPageRoute(builder: (_) => HomeScreen());
  }

  static Route? generateTasksRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainRoutes.TASKS_CALENDER_SCREEN:
        return MaterialPageRoute(builder: (_) => TasksCalenderScreen());

      case MainRoutes.ADD_TASK_SCREEN:
        return MaterialPageRoute(builder: (_) => AddTaskScreen());
    }
    return null;
  }
}
