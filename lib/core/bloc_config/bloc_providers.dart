import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_joddb/core/config/injection_container.dart';
import 'package:tasks_joddb/features/auth/presentaion/bloc/auth_bloc/auth_bloc.dart';
import 'package:tasks_joddb/features/main/presentaion/bloc/main_bloc/main_bloc.dart';
import 'package:tasks_joddb/features/main/presentaion/bloc/tasks_bloc/tasks_bloc.dart';

MultiBlocProvider listOfBlocProviders(Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => AuthBloc(getIt())),
      BlocProvider(create: (_) => MainBloc()),
    ],
    child: child,
  );
}

MultiBlocProvider listOfBlocProvidersForMainScreen(Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => TasksBloc(getIt())),
    ],
    child: child,
  );
}
