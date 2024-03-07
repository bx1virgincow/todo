part of 'todo_bloc.dart';

@immutable
sealed class TodoState {
  final TodoModel? todo;
  final List<TodoModel> listOfTodo;
  final String errorMessage;
  final Color color;

  const TodoState({
    required this.errorMessage,
    required this.listOfTodo,
    required this.todo,
    required this.color,
  });
}

final class TodoInitial extends TodoState {
  const TodoInitial({
    super.errorMessage = "",
    super.listOfTodo = const [],
    super.todo,
    super.color = Colors.blue,
  });
}

final class TodoLoaded extends TodoState {
  const TodoLoaded({
    super.errorMessage = "",
    required super.listOfTodo,
    required super.todo,
    required super.color,
  });
}

final class TodoFailed extends TodoState {
  const TodoFailed({
    required super.errorMessage,
    super.listOfTodo = const [],
    super.todo,
    super.color = Colors.blue,
  });
}

final class TodoSuccessState extends TodoState {
  const TodoSuccessState({
    super.errorMessage = "",
    super.listOfTodo = const [],
    super.todo,
    super.color = Colors.blue,
  });
}

final class ColorPickerState extends TodoState {
  ColorPickerState({
    super.errorMessage="",
    super.listOfTodo=const [],
    super.todo,
    required super.color,
  });
}
