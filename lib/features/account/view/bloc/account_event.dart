part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

final class OnRegisterUserEvent extends AccountEvent {
  final String firstname;
  final String lastname;
  final String email;

  OnRegisterUserEvent({
    required this.firstname,
    required this.lastname,
    required this.email,
  });
}

final class StayLoggedInEvent extends AccountEvent {
  final bool isRemember;
  StayLoggedInEvent({required this.isRemember});
}

final class GetUserEvent extends AccountEvent{
  final UserModel userModel;
  GetUserEvent({required this.userModel});
}