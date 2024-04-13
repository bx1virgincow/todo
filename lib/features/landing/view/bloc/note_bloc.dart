import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/common/result.dart';
import 'package:todo/features/landing/domain/model/todo_model.dart';
import 'package:todo/features/landing/domain/repository/todo_repository.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<TodoEvent, NoteState> {
  final TodoRepo _todoRepo = GetIt.I<TodoRepo>();
  final _noteStreamController = StreamController<List<TodoModel>>();

  NoteBloc() : super(NoteInitial()) {
    on<OnNoteLoadEvent>(_onNoteLoadEvent);
    on<OnAddNoteEvent>(_onAddNoteEvent);
    on<OnColorChangedEvent>(onColorChangedEvent);
    on<DropdownEvent>(_dropDownEvent);
    on<OnUpdateNoteEvent>(_onUpdateNoteEvent);
  }

  Stream<List<TodoModel>> get noteStream => _noteStreamController.stream;

  void dispose() {
    _noteStreamController.close();
    super.close();
  }

  FutureOr<void> _onNoteLoadEvent(
      OnNoteLoadEvent event, Emitter<NoteState> emit) async {
    try {
      var todoResponse = await _todoRepo.getNotes();

      if (todoResponse is Success) {
        log('TodoResponse: ${todoResponse.value}');

        List<TodoModel> todoModel = List.from(todoResponse.value);

        log('Todomodel: $todoModel');
        _noteStreamController.sink.add(todoModel); // Update the stream

        // add(OnTodoLoadEvent(listOfTodo: todoResponse.value ));
        emit(NoteLoadedState(listOfTodo: todoModel));
      } else if (todoResponse is Failed) {
        log('TodoResponse: $todoResponse:: response: ${todoResponse.value}');
        emit(NoteFailedState(errorMessage: todoResponse.value));
      }
    } catch (e) {
      log('Error message: $e');
      Failed(errorMessage: '', value: e.toString());
    }
  }

  FutureOr<void> _onAddNoteEvent(
      OnAddNoteEvent event, Emitter<NoteState> emit) async {
    try {
      Loading(value: 'Adding...');
      var response = await _todoRepo.addNote(
        event.title,
        event.description,
        event.color,
      );
      if (response is Success) {
        emit(TodoSuccessState());
      } else if (response is Failed) {
        emit(NoteFailedState(errorMessage: 'errorMessage'));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  FutureOr<void> onColorChangedEvent(
      OnColorChangedEvent event, Emitter<NoteState> emit) {
    emit(ColorPickerState(color: event.color));

    log('Color: ${event.color}');
  }

  FutureOr<void> _dropDownEvent(DropdownEvent event, Emitter<NoteState> emit) {
    emit(DropdownState(dropdown: event.selectedValue));
  }

  FutureOr<void> _onUpdateNoteEvent(OnUpdateNoteEvent event, Emitter<NoteState> emit) async{
    try{
      final response = await _todoRepo.updateNote(event.id, event.title, event.description, event.color);
      if(response is Success){
        log('success update');
      }else if(response is Failed){
        log('failed updating');
      }
    }
    catch(e){
      log('Update failed: $e');
      throw Exception(e);
    }
  }
}
