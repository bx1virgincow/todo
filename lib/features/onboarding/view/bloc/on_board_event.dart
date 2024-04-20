part of 'on_board_bloc.dart';

@immutable
sealed class OnBoardEvent {

}

final class OnPageChangedEvent extends OnBoardEvent{
  final int pageIndex;

  OnPageChangedEvent({required this.pageIndex});
}

final class NavigateToLandingPageEvent extends OnBoardEvent{}
