import 'package:dartz/dartz.dart';

import '../../data/models/task_model.dart';
import '../../data/repositories/tasks_repository.dart';

class TasksUsecases {
  final ITaskRepository _repository;
  TasksUsecases(this._repository);
  Future<Either<String, List<TaskModel>>> getAllTasks() async {
    return await _repository.getAllTasks();
  }

  Future<Either<String, String>> insertTask(TaskModel task) async {
    return await _repository.insertTask(task);
  }

  Future<Either<String, String>> updateTask(TaskModel task) async {
    return await _repository.updateTask(task);
  }

  Future<Either<String, List<TaskModel>>> getTasksOnDate(DateTime date) async {
    return await _repository.getTasksOnDate(date);
  }
}
