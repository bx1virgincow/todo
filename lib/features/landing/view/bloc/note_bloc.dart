import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/common/result.dart';
import 'package:todo/features/landing/domain/model/todo_model.dart';
import 'package:todo/features/landing/domain/repository/note_repository.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepo _todoRepo;

  NoteBloc(this._todoRepo) : super(const NoteInitial()) {
    on<OnNoteLoadEvent>(_onNoteLoadEvent);
    on<OnAddNoteEvent>(_onAddNoteEvent);
    on<OnColorChangedEvent>(onColorChangedEvent);
    on<DropdownEvent>(_dropDownEvent);
    on<OnUpdateNoteEvent>(_onUpdateNoteEvent);
    on<OnDeleteNoteEvent>(_onDeleteNoteEvent);
    on<SearchNoteEvent>(_searchNoteEvent);
  }

  FutureOr<void> _onNoteLoadEvent(
      OnNoteLoadEvent event, Emitter<NoteState> emit) async {
    try {
      var todoResponse = _todoRepo.getNotes();

      await for (var response in todoResponse) {
        if (response is Success) {
          log('TodoResponse: $response');

          List<NoteModel> todoModel = List.from(response.value);
          emit(NoteLoadedState(noteList: todoModel));
        } else if (response is Failed) {
          log('response: $response');
          emit(NoteFailedState(errorMessage: response.value));
        }
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
        emit(const TodoSuccessState());
      } else if (response is Failed) {
        emit(const NoteFailedState(errorMessage: 'errorMessage'));
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

  FutureOr<void> _onUpdateNoteEvent(
      OnUpdateNoteEvent event, Emitter<NoteState> emit) async {
    try {
      final response = _todoRepo.updateNote(
          event.id, event.title, event.description, event.color);
      if (response is Success) {
        log('success update');
      } else if (response is Failed) {
        log('failed updating');
      }
    } catch (e) {
      log('Update failed: $e');
      throw Exception(e);
    }
  }

  FutureOr<void> _onDeleteNoteEvent(
      OnDeleteNoteEvent event, Emitter<NoteState> emit) async {
    try {
      log('loading..please wait');
      final response = await _todoRepo.deleteNote(event.noteId);
      if (response is Success) {
        emit(const DeleteSuccessState());
      } else if (response is Failed) {
        emit(const DeleteFailedState(errorMessage: 'Failed to delete'));
      }
    } catch (e) {
      log('Deletion failed');
      emit(const DeleteFailedState(errorMessage: 'Failed to delete'));
    }
  }

  FutureOr<void> _searchNoteEvent(
      SearchNoteEvent event, Emitter<NoteState> emit) {
    try{
      List<NoteModel> noteList = state.noteList.where((searchValue) {
        return searchValue.title
            .toLowerCase()
            .contains(event.searchValue.toLowerCase());
      }).toList();

      log('value: ${event.searchValue}');
      emit(SearchNoteState(searchValue: event.searchValue, noteList: noteList));
    }catch(e){
      log('Error while searching: $e');
    }

  }
}
