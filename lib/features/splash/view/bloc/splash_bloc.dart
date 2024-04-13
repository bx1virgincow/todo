import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/common/token_data.dart';

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
    // var response = await getRememberMe();
    // log('splash response: $response');
    // if (response != null) {
    emit(NavigateToLandingScreenState());
    // } else {
    //   emit(NavigateToRegisterScreenState());
    // }
  }
}
