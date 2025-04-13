part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class UpdateSelectedTab extends MainEvent {
  int value;
  UpdateSelectedTab(this.value);

  @override
  List<Object> get props => [value];
}
