import 'package:flutter/material.dart';
import 'package:todo/common/result.dart';

abstract class TodoRepo {
  Future<Result> getNote(int id);

  Future<Result> getNotes();

  Future<Result> updateNote(
    int id,
    String title,
    String description,
    Color color,
  );

  Future<Result> deleteNote(int id);

  Future<Result> addNote(
    String title,
    String description,
    Color color,
  );
}
