part of 'account_bloc.dart';

@immutable
sealed class AccountState {}

final class AccountInitial extends AccountState {}

final class AccountLoadingState extends AccountState {}

final class AccountSuccessState extends AccountState {}

final class AccountFailedState extends AccountState {
  final String errorMessage;

  AccountFailedState({required this.errorMessage});
}

final class NavigateToWhenSuccessState extends AccountState {}

final class StayLoggedInState extends AccountState {
  bool isLoggedIn = false;

  StayLoggedInState({required this.isLoggedIn});
}

final class GetUserState extends AccountState {
  final UserModel userModel;
  GetUserState({required this.userModel});
}
