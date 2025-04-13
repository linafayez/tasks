import '../../../../core/network/sqflite_db.dart';
import '../models/task_model.dart';

abstract class ITasksDatasource {
  Future<List> getAllTasks();
  Future<List> getTasksOnDate(DateTime date);
  Future<int> insertTask(TaskModel task);
  Future<int> updateTask(TaskModel task);
}

class TasksDatasource implements ITasksDatasource {
  SqfliteDBHelper sqfliteDBHelper;
  TasksDatasource(this.sqfliteDBHelper);

  @override
  Future<List> getAllTasks() async {
    return await sqfliteDBHelper.getAllTasks();
  }

  @override
  Future<List> getTasksOnDate(DateTime date) async {
    return await sqfliteDBHelper.queryData(date);
  }

  @override
  Future<int> insertTask(TaskModel task) async {
    return await sqfliteDBHelper.insert(task.toMap());
  }

  @override
  Future<int> updateTask(TaskModel task) async {
    return await sqfliteDBHelper.updateData(task.toMap());
  }
}
