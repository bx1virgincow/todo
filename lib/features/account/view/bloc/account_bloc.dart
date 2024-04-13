import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/common/result.dart';
import 'package:todo/common/token_data.dart';
import 'package:todo/features/account/domain/data/user_data_model.dart';

import '../../domain/repository/account_repo.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepo _accountRepo;
  AccountBloc(this._accountRepo) : super(AccountInitial()) {
    on<OnRegisterUserEvent>(_onRegisterUserEvent);
    on<StayLoggedInEvent>(_stayLoggedInEvent);
    on<GetUserEvent>(_getUserEvent);
  }

  FutureOr<void> _onRegisterUserEvent(
      OnRegisterUserEvent event, Emitter<AccountState> emit) async {
    try {
      emit(AccountLoadingState());
      var response = await _accountRepo.createUser(
        event.firstname,
        event.lastname,
        event.email,
      );
      if (response is Success) {
        log('reg success: ${response.value}');
        emit(AccountSuccessState());
      } else if (response is Failed) {
        log('reg failed: ${response.value}');
        emit(AccountFailedState(
            errorMessage: 'Creation of account unsuccessful'));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  FutureOr<void> _stayLoggedInEvent(
      StayLoggedInEvent event, Emitter<AccountState> emit) async {
    emit(StayLoggedInState(isLoggedIn: event.isRemember));
    await setRememberMe(event.isRemember);
  }

  FutureOr<void> _getUserEvent(
      GetUserEvent event, Emitter<AccountState> emit) async {
    try {
      var response = await _accountRepo.getUser(event.userModel.email);

      if (response is Success) {
        log('resonse value: ${response.value}');
        UserModel userModel = response.value;
        emit(GetUserState(userModel: userModel));
      } else if (response is Failed) {
        emit(AccountFailedState(errorMessage: ''));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
