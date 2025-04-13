import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasks_joddb/core/navigation/custom_navigation.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<MainEvent>((event, emit) {
      if (event is UpdateSelectedTab) {
        CustomNavigator.selectedTab = event.value;
        emit(SelectedTabUpdated(CustomNavigator.selectedTab));
      }
    });
  }
}
