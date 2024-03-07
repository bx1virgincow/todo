
import 'package:flutter/material.dart';
import 'package:todo/common/result.dart';

abstract class TodoRepo{

  Future<Result> getTodo(int id);

  Future<Result> getTodos();

  Future<Result> updateTodo(String title, String description);

  Future<Result> deleteTodo(int id);

  Future<Result> addTodo(String title, String description, Color color);
}