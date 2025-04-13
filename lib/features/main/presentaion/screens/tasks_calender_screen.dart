import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tasks_joddb/core/navigation/custom_navigation.dart';
import 'package:tasks_joddb/core/widgets/custom_card.dart';
import 'package:tasks_joddb/core/widgets/custom_scaffold.dart';

import '../../../../core/widgets/custom_text.dart';
import '../../config/navigation/main_routes.dart';
import '../bloc/tasks_bloc/tasks_bloc.dart';
import '../widgets/task_card.dart';

class TasksCalenderScreen extends StatefulWidget {
  const TasksCalenderScreen({super.key});

  @override
  State<TasksCalenderScreen> createState() => _TasksCalenderScreenState();
}

class _TasksCalenderScreenState extends State<TasksCalenderScreen> {
  DateTime selectedDate = DateTime.now();
  late DateTime lastDayOfMonth;
  @override
  void initState() {
    context.read<TasksBloc>().add(GetTasksOnDate(selectedDate));
    lastDayOfMonth = DateTime.now().add(Duration(days: 30));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: CustomCard(
            color: Theme.of(context).primaryColor.withAlpha(200),
            child: StatefulBuilder(builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          DateFormat("dd-MM-yyyy").format(selectedDate),
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () {
                              CustomNavigator.pushInSubNavigator(MainRoutes.ADD_TASK_SCREEN).whenComplete(() {
                                context.read<TasksBloc>().add(GetTasksOnDate(selectedDate));
                              });
                            },
                            icon: Icon(Icons.add_box_rounded, color: Colors.white)),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                          lastDayOfMonth.difference(DateTime.now()).inDays,
                          (index) {
                            final currentDate = DateTime.now().add(Duration(days: index));
                            print(currentDate);
                            final dayName = DateFormat('E').format(currentDate);
                            return GestureDetector(
                              onTap: () {
                                state(() {
                                  selectedDate = currentDate;
                                  context.read<TasksBloc>().add(GetTasksOnDate(selectedDate));
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: index == 0 ? 10.w : 0.0, right: 10.w),
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: selectedDate.toIso8601String().split("T").first == currentDate.toIso8601String().split("T").first
                                      ? Colors.white12
                                      : null,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 42.0,
                                      width: 42.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        // color: selectedIndex == index ? Colors.orange : Colors.transparent,
                                        borderRadius: BorderRadius.circular(44.0),
                                      ),
                                      child: Text(
                                        dayName.substring(0, 1),
                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      "${currentDate.day}",
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Container(
                                      height: 2.0,
                                      width: 28.0,
                                      // color: selectedIndex == index ? Colors.orange : Colors.transparent,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )),
                ],
              );
            }),
          ),
        ),
        BlocBuilder<TasksBloc, TasksState>(
          buildWhen: (previous, current) =>
              current is GetFilteredTaskSuccess || current is FiltereTaskLoading || current is FiltereTasksFailed || current is UpdateTaskSuccess,
          builder: (context, state) {
            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.w),
                    child: CustomText(
                      "tasks",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: state is FiltereTaskLoading
                        ? const Center(child: CircularProgressIndicator())
                        : state is FiltereTasksFailed
                            ? CustomText(
                                state.message,
                                style: Theme.of(context).textTheme.labelLarge,
                              )
                            : context.read<TasksBloc>().filterdTasks.isEmpty
                                ? Center(
                                    child: CustomText(
                                    "no_tasks",
                                    style: Theme.of(context).textTheme.labelLarge,
                                  ))
                                : ListView.builder(
                                    itemCount: context.read<TasksBloc>().filterdTasks.length,
                                    itemBuilder: (context, index) {
                                      return TaskCard(context.read<TasksBloc>().filterdTasks[index]);
                                    },
                                  ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    ));
  }
}
