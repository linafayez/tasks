import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_joddb/core/navigation/custom_navigation.dart';
import 'package:tasks_joddb/core/widgets/custom_scaffold.dart';
import 'package:tasks_joddb/core/widgets/custom_text.dart';
import 'package:tasks_joddb/features/main/config/navigation/main_routes.dart';
import 'package:tasks_joddb/features/main/presentaion/bloc/tasks_bloc/tasks_bloc.dart';

import '../widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TasksBloc>().add(GetAllTasks());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                "tasks",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              IconButton(
                  onPressed: () {
                    CustomNavigator.pushInSubNavigator(MainRoutes.ADD_TASK_SCREEN);
                  },
                  icon: Icon(Icons.add))
            ],
          ),
          const Divider(),
          BlocBuilder<TasksBloc, TasksState>(
            buildWhen: (previous, current) =>
                current is GetTaskSuccess || current is Loading || current is Failed || current is UpdateTaskSuccess || current is AddTaskSuccess,
            builder: (context, state) {
              if (state is Failed) {
                return Center(child: CustomText(state.message));
              }
              return Expanded(
                child: context.read<TasksBloc>().tasks.isEmpty
                    ? Center(child: const CustomText("no_tasks"))
                    : ListView.builder(
                        itemCount: context.read<TasksBloc>().tasks.length,
                        itemBuilder: (context, index) {
                          return TaskCard(context.read<TasksBloc>().tasks[index]);
                        },
                      ),
              );
            },
          )
        ],
      ),
    );
  }
}
