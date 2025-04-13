import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasks_joddb/features/main/data/models/task_model.dart';

import '../../../domain/usecases/tasks_usecases.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksUsecases _usecases;
  List<TaskModel> tasks = [];
  List<TaskModel> filterdTasks = [];

  TasksBloc(this._usecases) : super(TasksInitial()) {
    on<TasksEvent>((event, emit) async {
      if (event is GetAllTasks) {
        emit(Loading());
        var response = await _usecases.getAllTasks();
        response.fold((l) => emit(Failed(l)), (r) {
          tasks = r;
          emit(GetTaskSuccess());
        });
      } else if (event is AddTask) {
        emit(Loading());
        var response = await _usecases.insertTask(event.task);
        response.fold((l) => emit(Failed(l)), (r) {
          tasks.add(event.task);
          emit(AddTaskSuccess());
        });
      } else if (event is UpdateTask) {
        emit(Loading());
        var response = await _usecases.updateTask(event.task);
        response.fold((l) => {event.task.isCompleted = !event.task.isCompleted, emit(Failed(l))}, (r) {
          if (filterdTasks.any((i) => i.id == event.task.id))
            filterdTasks.firstWhere((i) => i.id == event.task.id).isCompleted = event.task.isCompleted;

          emit(UpdateTaskSuccess());
        });
      } else if (event is GetTasksOnDate) {
        emit(FiltereTaskLoading());
        var response = await _usecases.getTasksOnDate(event.date);
        response.fold((l) => emit(FiltereTasksFailed(l)), (r) {
          filterdTasks = r;
          emit(GetFilteredTaskSuccess());
        });
      }
    });
  }
}
