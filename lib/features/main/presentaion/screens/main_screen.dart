import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_joddb/core/navigation/custom_navigation.dart';
import 'package:tasks_joddb/core/widgets/custom_scaffold.dart';
import 'package:tasks_joddb/features/main/config/enums/tabs_enums.dart';
import 'package:tasks_joddb/features/main/presentaion/bloc/main_bloc/main_bloc.dart';

import '../../config/navigation/main_navigation.dart';
import '../../config/navigation/main_routes.dart';
import '../bloc/tasks_bloc/tasks_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pages = [];

  @override
  void initState() {
    CustomNavigator.navigatorKeysBottomNav = [
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
    ];
    pages = [
      Navigator(
        key: CustomNavigator.navigatorKeysBottomNav[0],
        initialRoute: MainRoutes.HOME_SCREEN,
        onGenerateRoute: MainNavigation.generateHomeRoute,
      ),
      Navigator(
        key: CustomNavigator.navigatorKeysBottomNav[1],
        initialRoute: MainRoutes.TASKS_CALENDER_SCREEN,
        onGenerateRoute: MainNavigation.generateTasksRoute,
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return CustomScaffold(
            body: IndexedStack(index: CustomNavigator.selectedTab, children: pages),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: CustomNavigator.selectedTab,
                onTap: (value) {
                  if (value == 0) {
                    context.read<TasksBloc>().add(GetAllTasks());
                  }
                  context.read<MainBloc>().add(UpdateSelectedTab(value));
                },
                items: TabsEnum.values
                    .map((e) => BottomNavigationBarItem(
                          icon: Icon(e.icon),
                          label: e.name,
                        ))
                    .toList()));
      },
    );
  }
}
