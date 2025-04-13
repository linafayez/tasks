import 'package:tasks_joddb/core/config/injection_container.dart';

import '../../../core/network/sqflite_db.dart';
import '../data/datasource/tasks_datasource.dart';
import '../data/repositories/tasks_repository.dart';
import '../domain/repositories/tasks_repository.dart';
import '../domain/usecases/tasks_usecases.dart';

class TasksDependencyInjectionInit {
  static final TasksDependencyInjectionInit _singleton = TasksDependencyInjectionInit._();

  factory TasksDependencyInjectionInit() => _singleton;

  TasksDependencyInjectionInit._();

  /// Register the Basic Singleton
  Future<void> registerSingletons() async {
    var db = await SqfliteDBHelper.getInstanceOfTasksDB();
    final tasks = tasksUsecases(db);

    getIt.registerLazySingleton(() => tasks);
  }

  TasksUsecases tasksUsecases(SqfliteDBHelper sqfliteDBHelper) {
    ITasksDatasource datasource = TasksDatasource(sqfliteDBHelper);
    ITaskRepository repository = TaskRepository(datasource);
    return TasksUsecases(repository);
  }
}
