import '../../../../common/result.dart';

abstract class AccountRepo {
  //create user account
  Future<Result> createUser(String firstname, String lastname, String email);

  //delete user
  Future<Result> deleteUser();

  //edit user info
  Future<Result> editUser();

  //get user
  Future<Result> getUser(String email);
}
