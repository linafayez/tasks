import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasks_joddb/core/widgets/custom_card.dart';
import 'package:tasks_joddb/core/widgets/custom_text.dart';
import 'package:tasks_joddb/features/main/data/models/task_model.dart';

import '../bloc/tasks_bloc/tasks_bloc.dart';

class TaskCard extends StatelessWidget {
  TaskCard(this.task, {super.key});
  TaskModel task;
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: Theme.of(context).primaryColor.withAlpha(200),
      child: Row(
        children: [
          Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                task.isCompleted = !task.isCompleted;
                context.read<TasksBloc>().add(UpdateTask(task));
              }),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  task.name,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
                ),
                CustomText(
                  task.description,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomText(
                        DateFormat("dd-MM-yyyy").format(task.taskData),
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
                      ),
                      CustomText(
                        "${task.startTime} - ${task.endTime}",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
