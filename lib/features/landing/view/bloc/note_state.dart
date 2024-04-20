part of 'note_bloc.dart';

@immutable
sealed class NoteState {
  final NoteModel? todo;
  final List<NoteModel> noteList;
  final String errorMessage;
  final Color color;
  final String dropdown;

  const NoteState({
    required this.errorMessage,
    required this.noteList,
    required this.todo,
    required this.color,
    required this.dropdown,
  });
}

class NoteInitial extends NoteState {
  const NoteInitial({
    super.errorMessage = "",
    super.noteList = const [],
    super.todo,
    super.color = Colors.blue,
    super.dropdown = '',
  });
}

class NoteLoadedState extends NoteState {
  const NoteLoadedState(
      {super.errorMessage = "",
      required super.noteList,
      super.todo,
      super.color = Colors.blue,
      super.dropdown = ''});
}

class NoteAddedState extends NoteState {
  const NoteAddedState(
      {super.errorMessage = "",
      required super.noteList,
      super.todo,
      super.color = Colors.blue,
      super.dropdown = ''});
}

class NoteFailedState extends NoteState {
  const NoteFailedState(
      {required super.errorMessage,
      super.noteList = const [],
      super.todo,
      super.color = Colors.blue,
      super.dropdown = ''});
}

class TodoSuccessState extends NoteState {
  const TodoSuccessState(
      {super.errorMessage = "",
      super.noteList = const [],
      super.todo,
      super.color = Colors.blue,
      super.dropdown = ''});
}

class ColorPickerState extends NoteState {
  const ColorPickerState(
      {super.errorMessage = "",
      super.noteList = const [],
      super.todo,
      required super.color,
      super.dropdown = ''});
}

class DropdownState extends NoteState {
  const DropdownState({
    super.errorMessage = '',
    super.noteList = const [],
    super.todo,
    super.color = Colors.blue,
    required super.dropdown,
  });
}

class NoteDeletedState extends NoteState {
  const NoteDeletedState({
    super.errorMessage = '',
    super.noteList = const [],
    super.todo,
    super.color = Colors.blue,
    super.dropdown = '',
  });
}

class DeleteSuccessState extends NoteState{
  const DeleteSuccessState({
    super.errorMessage='',
    super.noteList = const [],
    super.todo,
    super.color = Colors.blue,
    super.dropdown = '',
});
}

class DeleteFailedState extends NoteState {
  const DeleteFailedState({
    required super.errorMessage,
    super.noteList = const [],
    super.todo,
    super.color = Colors.blue,
    super.dropdown = '',
  });
}
