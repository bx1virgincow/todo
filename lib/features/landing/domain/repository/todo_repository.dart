import 'package:flutter/material.dart';
import 'package:todo/common/result.dart';

abstract class TodoRepo {
  Future<Result> getTodo(int id);

  Future<Result> getTodos();

  Future<Result> updateTodo(
    int id,
    String title,
    String description,
    Color color,
    String category,
  );

  Future<Result> deleteTodo(int id);

  Future<Result> addTodo(
    String title,
    String description,
    Color color,
    String category,
  );
}
