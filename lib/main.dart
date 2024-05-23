import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/db/sql_helper.dart';
import 'package:todo/dependency_injection.dart';
import 'package:todo/features/account/view/ui/register_screen.dart';
import 'package:todo/features/landing/data/local/local_note_repo_impl.dart';
import 'package:todo/features/landing/view/ui/landing_screen.dart';
import 'package:todo/features/onboarding/view/bloc/on_board_bloc.dart';
import 'package:todo/features/onboarding/view/ui/on_board_screen.dart';
import 'package:todo/features/splash/view/bloc/splash_bloc.dart';
import 'package:todo/features/splash/view/ui/splash_screen.dart';
import 'package:todo/services/notification_service.dart';

import 'features/account/data/sources/local/local_repo_impl.dart';
import 'features/account/view/bloc/account_bloc.dart';
import 'features/landing/view/bloc/note_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependency();
  // BackgroundTasks.initialize();
  LocalNotifications.initialize();

  await openDatabase(
    join(await getDatabasesPath(), '${DatabaseHelper.instance.database}'),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashBloc()
            ..add(
              OnSplashEvent(),
            ),
          child: const SplashScreen(),
        ),
        BlocProvider(
          create: (context) => OnBoardBloc(),
          child: const OnBoardingScreen(),
        ),
        BlocProvider(
          create: (context) => NoteBloc(LocalNoteRepoImpl()),
          child: const LandingScreen(),
        ),
        BlocProvider(
          create: (context) => AccountBloc(
            LocalUserRepoImpl(),
          ),
          child: const RegisterScreen(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
