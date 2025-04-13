part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TasksEvent {
  TaskModel task;
  AddTask(this.task);
}

class GetAllTasks extends TasksEvent {}

class GetTasksOnDate extends TasksEvent {
  DateTime date;
  GetTasksOnDate(this.date);
}

class UpdateTask extends TasksEvent {
  TaskModel task;
  UpdateTask(this.task);
}
