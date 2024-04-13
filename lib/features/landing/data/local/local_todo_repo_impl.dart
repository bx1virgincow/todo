import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/common/result.dart';
import 'package:todo/db/sql_helper.dart';
import 'package:todo/features/landing/domain/model/todo_model.dart';
import 'package:todo/features/landing/domain/repository/todo_repository.dart';

class LocalNoteRepoImpl extends TodoRepo {
  @override
  Future<Result> addNote(
    String title,
    String description,
    Color color,
  ) async {
    try {
      Loading(value: 'Loading...');
      var db = await DatabaseHelper.instance.database;
      log('Color: $color');
      Map<String, dynamic> data = {
        'title': title,
        'description': description,
        'color': color.value,
      };

      log('data: $data');

      var response = await db?.insert(
        DatabaseHelper.noteTable,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return Success(value: response);
    } catch (e) {
      return Failed(errorMessage: 'Error..', value: e.toString());
    }
  }

  @override
  Future<Result> deleteNote(int id) async {
    try {
      var db = await DatabaseHelper.instance.database;
      var response = await db
          ?.delete(DatabaseHelper.noteTable, where: 'id=?', whereArgs: [id]);
      return Success(value: response);
    } catch (e) {
      return Failed(errorMessage: 'errorMessage', value: e);
    }
  }

  @override
  Future<Result> getNote(int id) {
    // TODO: implement getTodo
    throw UnimplementedError();
  }

  @override
  Future<Result> getNotes() async {
    try {
      var db = await DatabaseHelper.instance.database;

      var todoData = await db!.query(DatabaseHelper.noteTable, orderBy: 'id');
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
  Future<Result> updateNote(
    int id,
    String title,
    String description,
    Color color,
  ) async {
    try {
      var db = await DatabaseHelper.instance.database;

      Map<String, dynamic> values = {
        'id': id,
        'title': title,
        'description': description,
        'color': color.value,
      };

      var response = await db?.update(DatabaseHelper.noteTable, values,
          where: 'id=?', whereArgs: [id]);

      return Success(value: response);
    } catch (e) {
      return Failed(errorMessage: 'failed to update ${e.toString()}', value: e);
    }
  }
}
