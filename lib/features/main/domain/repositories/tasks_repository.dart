import 'package:dartz/dartz.dart';
import 'package:tasks_joddb/features/main/data/models/task_model.dart';

import '../../data/datasource/tasks_datasource.dart';
import '../../data/repositories/tasks_repository.dart';

class TaskRepository implements ITaskRepository {
  final ITasksDatasource _datasource;
  TaskRepository(this._datasource);

  @override
  Future<Either<String, List<TaskModel>>> getAllTasks() async {
    try {
      var response = await _datasource.getAllTasks();
      print(response);
      return Right(response.map((e) => TaskModel.fromMap(e)).toList());
    } catch (e) {
      print(e);
      return const Left("common_error");
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> getTasksOnDate(DateTime date) async {
    try {
      var response = await _datasource.getTasksOnDate(DateTime(date.year, date.month, date.day));
      print(response);
      return Right(response.map((e) => TaskModel.fromMap(e)).toList());
    } catch (_) {
      return const Left("common_error");
    }
  }

  @override
  Future<Either<String, String>> insertTask(TaskModel task) async {
    try {
      var response = await _datasource.insertTask(task);
      print(response);
      task.id = response;
      return response != 0 ? Right("common_success") : Left("common_error");
    } catch (_) {
      return const Left("common_error");
    }
  }

  @override
  Future<Either<String, String>> updateTask(TaskModel task) async {
    try {
      var response = await _datasource.insertTask(task);
      return response != 0 ? Right("common_success") : Left("common_error");
    } catch (_) {
      return const Left("common_error");
    }
  }
}
