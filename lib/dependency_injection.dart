
import 'package:get_it/get_it.dart';
import 'package:todo/features/landing/data/local/local_todo_repo_impl.dart';
import 'package:todo/features/landing/domain/repository/todo_repository.dart';
import 'package:todo/features/landing/view/bloc/todo_bloc.dart';
import 'package:todo/features/splash/view/bloc/splash_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeDependency() async{
  
  getIt.registerFactory<TodoBloc>(() => getIt());

  getIt.registerFactory<SplashBloc>(() => getIt());

 GetIt.I.registerSingleton<TodoRepo>(LocalTodoRepoImpl());

}