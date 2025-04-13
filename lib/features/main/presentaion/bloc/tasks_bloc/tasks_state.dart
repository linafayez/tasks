part of 'tasks_bloc.dart';

sealed class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

final class TasksInitial extends TasksState {}

class Loading extends TasksState {}

class Failed extends TasksState {
  final String message;
  const Failed(this.message);
}

class AddTaskSuccess extends TasksState {}

class UpdateTaskSuccess extends TasksState {}

class GetTaskSuccess extends TasksState {}

class GetFilteredTaskSuccess extends TasksState {}

class FiltereTaskLoading extends TasksState {}

class FiltereTasksFailed extends TasksState {
  final String message;
  const FiltereTasksFailed(this.message);
}
