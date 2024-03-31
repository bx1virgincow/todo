import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/common/result.dart';
import 'package:todo/db/sql_helper.dart';
import 'package:todo/features/landing/domain/model/todo_model.dart';
import 'package:todo/features/landing/domain/repository/todo_repository.dart';

class LocalTodoRepoImpl extends TodoRepo {
  @override
  Future<Result> addTodo(
    String title,
    String description,
    Color color,
    String category,
  ) async {
    try {
      Loading(value: 'Loading...');
      var db = await DatabaseHelper.instance.database;
      log('Color: $color');
      Map<String, dynamic> data = {
        'title': title,
        'description': description,
        'color': color.value,
        'category': category,
      };

      log('data: $data');

      var response = await db?.insert(
        DatabaseHelper.todoTable,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return Success(value: response);
    } catch (e) {
      return Failed(errorMessage: 'Error..', value: e.toString());
    }
  }

  @override
  Future<Result> deleteTodo(int id) async {
    try {
      var db = await DatabaseHelper.instance.database;
      var response = await db
          ?.delete(DatabaseHelper.todoTable, where: 'id?=', whereArgs: [id]);
      return Success(value: response);
    } catch (e) {
      return Failed(errorMessage: 'errorMessage', value: e);
    }
  }

  @override
  Future<Result> getTodo(int id) {
    // TODO: implement getTodo
    throw UnimplementedError();
  }

  @override
  Future<Result> getTodos() async {
    try {
      var db = await DatabaseHelper.instance.database;

      var todoData = await db!.query(DatabaseHelper.todoTable, orderBy: 'id');
      log('all todo : $todoData');
      var results = todoData.map((e) => TodoModel.fromJson(e)).toList();
      return Success(value: results);
    } catch (e) {
      return Failed(
          errorMessage: 'Error fetching data from the backend $e',
          value: 'Error ${e.toString()}');
    }
  }

  @override
  Future<Result> updateTodo(
    int id,
    String title,
    String description,
    Color color,
    String category,
  ) async {
    try {
      var db = await DatabaseHelper.instance.database;

      Map<String, dynamic> values = {
        'title': title,
        'description': description,
        'color': color.value,
        'category': category,
      };

      var response = await db?.update(DatabaseHelper.todoTable, values,
          where: 'id?=', whereArgs: [id]);

      return Success(value: response);
    } catch (e) {
      return Failed(errorMessage: 'failed to update ${e.toString()}', value: e);
    }
  }
}
