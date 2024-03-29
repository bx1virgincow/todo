import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<OnSplashEvent>(_onSplashEvent);
  }

  //on splash event
  FutureOr<void> _onSplashEvent(
      OnSplashEvent event, Emitter<SplashState> emit) async {
    emit(SplashLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(SplashLoaded());
    await Future.delayed(const Duration(seconds: 1));
    emit(NavigateToLandingScreenState());
  }
}
