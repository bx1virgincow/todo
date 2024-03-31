part of 'todo_bloc.dart';

@immutable
sealed class TodoState {
  TodoModel? todo;
  List<TodoModel> listOfTodo;
  String errorMessage;
  Color color;
  String dropdown;

  TodoState({
    required this.errorMessage,
    required this.listOfTodo,
    required this.todo,
    required this.color,
    required this.dropdown,
  });
}

class TodoInitial extends TodoState {
  TodoInitial({
    super.errorMessage = "",
    super.listOfTodo = const [],
    super.todo,
    super.color = Colors.blue,  super.dropdown='',
  });
}

class TodoLoaded extends TodoState {
  TodoLoaded({
    super.errorMessage = "",
    required super.listOfTodo,
    super.todo,
    super.color = Colors.blue,
    super.dropdown=''
  });
}

class TodoAdded extends TodoState {
  TodoAdded({
    super.errorMessage = "",
    required super.listOfTodo,
    super.todo,
    super.color = Colors.blue,
    super.dropdown=''
  });
}

class TodoFailed extends TodoState {
  TodoFailed({
    required super.errorMessage,
    super.listOfTodo = const [],
    super.todo,
    super.color = Colors.blue,
    super.dropdown=''
  });
}

class TodoSuccessState extends TodoState {
  TodoSuccessState({
    super.errorMessage = "",
    super.listOfTodo = const [],
    super.todo,
    super.color = Colors.blue,
    super.dropdown=''
  });
}

class ColorPickerState extends TodoState {
  ColorPickerState({
    super.errorMessage = "",
    super.listOfTodo = const [],
    super.todo,
    required super.color,
    super.dropdown=''
  });
}

class DropdownState extends TodoState {

  DropdownState({
    super.errorMessage = '',
    super.listOfTodo = const [],
    super.todo,
    super.color = Colors.blue,
    required super.dropdown,
  });
}
