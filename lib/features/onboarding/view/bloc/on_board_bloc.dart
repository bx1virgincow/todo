import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/common/token_data.dart';

part 'on_board_event.dart';
part 'on_board_state.dart';

class OnBoardBloc extends Bloc<OnBoardEvent, OnBoardState> {
  OnBoardBloc() : super(OnBoardState()) {
    //events
    on<OnPageChangedEvent>(_onPageChangedEvent);
    on<NavigateToLandingPageEvent>(_navigateToLandingPageEvent);
  }

  FutureOr<void> _onPageChangedEvent(
      OnPageChangedEvent event, Emitter<OnBoardState> emit) {
    emit(OnBoardState(pageIndex: event.pageIndex));
  }

  FutureOr<void> _navigateToLandingPageEvent(
      NavigateToLandingPageEvent event, Emitter<OnBoardState> emit) async{
    await setRememberMe(true);
    emit(NavigateToLandingPageState());
  }
}
