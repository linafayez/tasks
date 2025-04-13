part of 'main_bloc.dart';

sealed class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

final class MainInitial extends MainState {}

class SelectedTabUpdated extends MainState {
  final int value;
  SelectedTabUpdated(this.value);

  @override
  List<Object> get props => [value];
}
