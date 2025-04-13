import 'package:dartz/dartz.dart';

import '../models/task_model.dart';

abstract class ITaskRepository {
  Future<Either<String, List<TaskModel>>> getAllTasks();
  Future<Either<String, List<TaskModel>>> getTasksOnDate(DateTime date);
  Future<Either<String, String>> insertTask(TaskModel task);
  Future<Either<String, String>> updateTask(TaskModel task);
}
