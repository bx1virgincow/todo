import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:todo/common/result.dart';
import 'package:todo/db/sql_helper.dart';
import 'package:todo/features/account/domain/data/user_data_model.dart';
import 'package:todo/features/account/domain/repository/account_repo.dart';

class LocalUserRepoImpl implements AccountRepo {
  @override
  Future<Result> createUser(
      String firstname, String lastname, String email) async {
    try {
      final db = await DatabaseHelper.instance.database;
      Map<String, dynamic> values = {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
      };
      final response = await db?.insert(DatabaseHelper.userTable, values,
          conflictAlgorithm: ConflictAlgorithm.replace);
      log('user response: $response');
      return Success(value: response);
    } catch (e) {
      return Failed(errorMessage: 'errorMessage ${e.toString()}', value: e);
    }
  }

  @override
  Future<Result> deleteUser() {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Result> editUser() {
    // TODO: implement editUser
    throw UnimplementedError();
  }

  @override
  Future<Result> getUser(String email) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final response = await db?.query(DatabaseHelper.userTable,
          whereArgs: [email], where: 'email?=');
      final userData = response?.map((e) => UserModel.fromJson(e)).toList();
      return Success(value: userData);
    } catch (e) {
      return Failed(errorMessage: 'errorMessage $e', value: e);
    }
  }
}
