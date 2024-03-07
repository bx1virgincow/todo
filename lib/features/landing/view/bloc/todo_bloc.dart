import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:todo/common/result.dart';
import 'package:todo/features/landing/domain/model/todo_model.dart';
import 'package:todo/features/landing/domain/repository/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepo _todoRepo = GetIt.I<TodoRepo>();
  TodoBloc() : super(const TodoInitial()) {
    on<OnTodoLoadEvent>(_onTodoLoadEvent);
    on<OnAddTodoEvent>(_onAddTodoEvent);
    on<OnColorChangedEvent>(onColorChangedEvent);
  }

  FutureOr<void> _onTodoLoadEvent(
      OnTodoLoadEvent event, Emitter<TodoState> emit) async {
    try {
      var todoResponse = await _todoRepo.getTodos();

      log('TodoResponse: $todoResponse');

      // add(OnTodoLoadEvent(listOfTodo: todoResponse.value ));
      emit(TodoLoaded(listOfTodo: todoResponse.value, todo: null, color: todoResponse.value['color'],));
    } catch (e) {
      Failed(errorMessage: '', value: e.toString());
    }
  }

  FutureOr<void> _onAddTodoEvent(
      OnAddTodoEvent event, Emitter<TodoState> emit) async {
    try {
      Loading(value: 'Adding...');
      await _todoRepo.addTodo(
        event.title,
        event.description,
        event.color,
      );
      emit(const TodoSuccessState());
    } catch (e) {
      throw Exception(e);
    }
  }

  FutureOr<void> onColorChangedEvent(
      OnColorChangedEvent event, Emitter<TodoState> emit) {
    emit(ColorPickerState(color: event.color));

    log('Color: ${event.color}');
  }
}
