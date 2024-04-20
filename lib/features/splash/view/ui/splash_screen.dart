import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/onboarding/view/ui/on_board_screen.dart';
import 'package:todo/features/splash/view/bloc/splash_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<SplashBloc, SplashState>(
          builder: (context, state) {
            if (state is SplashLoading) {
              return SvgPicture.asset('assets/splash_assets/note_logo_svg.svg');
            } else if (state is SplashLoaded) {
              return SvgPicture.asset('assets/splash_assets/note_logo_svg.svg');
            } else {
              return const SizedBox();
            }
          },
          listener: (BuildContext context, SplashState state) {
            if (state is NavigateToLandingScreenState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const OnBoardingScreen(),
                ),
              );
            }
            // if (state is NavigateToRegisterScreenState) {
            //   Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const RegisterScreen(),
            //     ),
            //   );
            // }
          },
        ),
      ),
    );
  }
}
