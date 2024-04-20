import 'package:flutter/material.dart';
import 'package:todo/common/result.dart';

abstract class NoteRepo {
  Stream<Result> getNote(int id);

  Stream<Result> getNotes();

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
