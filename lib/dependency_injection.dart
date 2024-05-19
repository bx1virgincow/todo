import 'package:get_it/get_it.dart';
import 'package:todo/features/account/view/bloc/account_bloc.dart';
import 'package:todo/features/landing/data/local/local_note_repo_impl.dart';
import 'package:todo/features/landing/domain/repository/note_repository.dart';
import 'package:todo/features/onboarding/view/bloc/on_board_bloc.dart';
import 'package:todo/features/splash/view/bloc/splash_bloc.dart';

import 'features/landing/view/bloc/note_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeDependency() async {
  getIt.registerFactory<NoteBloc>(() => NoteBloc(getIt()));

  getIt.registerFactory<SplashBloc>(() => SplashBloc());

  getIt.registerFactory<AccountBloc>(() => AccountBloc(getIt()));

  getIt.registerFactory<OnBoardBloc>(() => OnBoardBloc());

  getIt.registerLazySingleton<NoteRepo>(() => LocalNoteRepoImpl());
}
