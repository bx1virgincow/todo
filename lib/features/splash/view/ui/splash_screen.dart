import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/account/view/ui/register_screen.dart';
import 'package:todo/features/landing/view/ui/landing_screen.dart';
import 'package:todo/features/splash/view/bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<SplashBloc, SplashState>(
          builder: (context, state) {
            if (state is SplashLoading) {
              return const Text('Initializing..');
            } else if (state is SplashLoaded) {
              return const Text('Loading...');
            } else {
              return const SizedBox();
            }
          },
          listener: (BuildContext context, SplashState state) {
            if (state is NavigateToLandingScreenState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LandingScreen(),
                ),
              );
            }
            if (state is NavigateToRegisterScreenState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterScreen(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
