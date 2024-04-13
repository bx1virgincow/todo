part of 'note_bloc.dart';

@immutable
sealed class NoteState {
  TodoModel? todo;
  List<TodoModel> listOfTodo;
  String errorMessage;
  Color color;
  String dropdown;

  NoteState({
    required this.errorMessage,
    required this.listOfTodo,
    required this.todo,
    required this.color,
    required this.dropdown,
  });
}

class NoteInitial extends NoteState {
  NoteInitial({
    super.errorMessage = "",
    super.listOfTodo = const [],
    super.todo,
    super.color = Colors.blue,
    super.dropdown = '',
  });
}

class NoteLoadedState extends NoteState {
  NoteLoadedState(
      {super.errorMessage = "",
      required super.listOfTodo,
      super.todo,
      super.color = Colors.blue,
      super.dropdown = ''});
}

class NoteAddedState extends NoteState {
  NoteAddedState(
      {super.errorMessage = "",
      required super.listOfTodo,
      super.todo,
      super.color = Colors.blue,
      super.dropdown = ''});
}

class NoteFailedState extends NoteState {
  NoteFailedState(
      {required super.errorMessage,
      super.listOfTodo = const [],
      super.todo,
      super.color = Colors.blue,
      super.dropdown = ''});
}

class TodoSuccessState extends NoteState {
  TodoSuccessState(
      {super.errorMessage = "",
      super.listOfTodo = const [],
      super.todo,
      super.color = Colors.blue,
      super.dropdown = ''});
}

class ColorPickerState extends NoteState {
  ColorPickerState(
      {super.errorMessage = "",
      super.listOfTodo = const [],
      super.todo,
      required super.color,
      super.dropdown = ''});
}

class DropdownState extends NoteState {
  DropdownState({
    super.errorMessage = '',
    super.listOfTodo = const [],
    super.todo,
    super.color = Colors.blue,
    required super.dropdown,
  });
}
