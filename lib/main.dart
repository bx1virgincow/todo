import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/dependency_injection.dart';
import 'package:todo/features/landing/view/bloc/todo_bloc.dart';
import 'package:todo/features/landing/view/ui/landing_screen.dart';
import 'package:todo/features/splash/view/bloc/splash_bloc.dart';
import 'package:todo/features/splash/view/ui/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashBloc()..add(OnSplashEvent()),
          child: const SplashScreen(),
        ),
        BlocProvider(
          create: (context) => TodoBloc(),
          child: const LandingScreen(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
