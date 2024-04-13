import 'package:get_it/get_it.dart';
import 'package:todo/features/account/view/bloc/account_bloc.dart';
import 'package:todo/features/landing/data/local/local_todo_repo_impl.dart';
import 'package:todo/features/landing/domain/repository/todo_repository.dart';
import 'package:todo/features/splash/view/bloc/splash_bloc.dart';

import 'features/landing/view/bloc/note_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeDependency() async {
  getIt.registerFactory<NoteBloc>(() => getIt());

  getIt.registerFactory<SplashBloc>(() => getIt());

  getIt.registerFactory<AccountBloc>(() => getIt());

  GetIt.I.registerSingleton<TodoRepo>(LocalNoteRepoImpl());
}
