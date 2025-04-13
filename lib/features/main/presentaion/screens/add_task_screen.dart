import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasks_joddb/core/config/app_localization.dart';
import 'package:tasks_joddb/core/config/enums/size_enum.dart';
import 'package:tasks_joddb/core/config/validation.dart';
import 'package:tasks_joddb/core/navigation/custom_navigation.dart';
import 'package:tasks_joddb/core/widgets/custom_app_logo.dart';
import 'package:tasks_joddb/core/widgets/custom_button.dart';
import 'package:tasks_joddb/core/widgets/custom_scaffold.dart';
import 'package:tasks_joddb/features/main/data/models/task_model.dart';
import 'package:tasks_joddb/features/main/presentaion/bloc/tasks_bloc/tasks_bloc.dart';

import '../../../../core/widgets/cusom_text_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final name = TextEditingController();
  final description = TextEditingController();
  final date = TextEditingController();
  final startTime = TextEditingController();
  final endTime = TextEditingController();
  final fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Form(
        key: fromKey,
        child: SingleChildScrollView(
          child: BlocConsumer<TasksBloc, TasksState>(
            listener: (context, state) {
              if (state is Failed) {
                Fluttertoast.showToast(msg: AppLocalization.of(context).getTranslatedValues(state.message));
              } else if (state is AddTaskSuccess) {
                CustomNavigator.popInSubNavigator();
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    children: [
                      BackButton(),
                    ],
                  ),
                  CustomAppLogo(
                    size: SizeEnum.small,
                  ),
                  CustomTextField(
                    controller: name,
                    labelText: "name",
                    validator: (value) {
                      return AppValidation.isValid(value ?? "");
                    },
                  ),
                  CustomTextField(
                    controller: date,
                    labelText: "date",
                    onTap: () {
                      showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 500))).then((value) {
                        if (value != null) {
                          date.text = value.toString().split(" ").first;
                        }
                      });
                    },
                    validator: (value) {
                      return AppValidation.isValid(value ?? "");
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: startTime,
                          labelText: "start_time",
                          onTap: () {
                            showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                              startTime.text = value?.format(context) ?? "";
                            });
                          },
                          validator: (value) {
                            return AppValidation.isValid(value ?? "");
                          },
                        ),
                      ),
                      SizedBox(width: 25.w),
                      Expanded(
                        child: CustomTextField(
                          controller: endTime,
                          labelText: "end_time",
                          onTap: () {
                            showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                              endTime.text = value?.format(context) ?? "";
                            });
                          },
                          validator: (value) {
                            return AppValidation.isValid(value ?? "");
                          },
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                    maxLines: 5,
                    controller: description,
                    labelText: "description",
                    validator: (value) {
                      return AppValidation.isValid(value ?? "");
                    },
                  ),
                  CustomButton(
                      onPressed: () {
                        print(DateTime.parse(date.text));
                        print(DateTime.parse(date.text).millisecondsSinceEpoch);

                        if (fromKey.currentState?.validate() ?? false) {
                          context.read<TasksBloc>().add(
                              AddTask(TaskModel(null, name.text, description.text, false, DateTime.parse(date.text), startTime.text, endTime.text)));
                        }
                      },
                      label: state is Loading ? null : "create_task"),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
