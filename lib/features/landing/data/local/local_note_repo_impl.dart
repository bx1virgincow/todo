import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/common/result.dart';
import 'package:todo/db/sql_helper.dart';
import 'package:todo/features/landing/domain/model/todo_model.dart';
import 'package:todo/features/landing/domain/repository/note_repository.dart';

class LocalNoteRepoImpl extends NoteRepo {
  @override
  Future<Result> addNote(
    String title,
    String description,
    Color color,
  ) async {
    try {
      Loading(value: 'Loading...');
      var db = await DatabaseHelper.instance.database;
      Map<String, dynamic> data = {
        'title': title,
        'description': description,
        'color': color.value,
      };

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
  Stream<Result> getNote(int id) {
    throw UnimplementedError();
  }

  @override
  Stream<Result> getNotes() async* {
    try {
      var db = await DatabaseHelper.instance.database;

      var todoData = await db!.query(DatabaseHelper.noteTable, orderBy: 'id');
      log('all todo : $todoData');
      var results = todoData.map((e) => NoteModel.fromJson(e)).toList();
      yield Success(value: results);
    } catch (e) {
      yield Failed(
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

      log('values: $values');

      var response = await db?.update(DatabaseHelper.noteTable, values,
          where: 'id=?', whereArgs: [id]);

      log('response: $response');

      return Success(value: response);
    } catch (e) {
      return  Failed(errorMessage: 'failed to update ${e.toString()}', value: e);
    }
  }
}
