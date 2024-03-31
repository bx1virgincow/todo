part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class OnTodoLoadEvent extends TodoEvent {
  final List<TodoModel> listOfTodo;

  OnTodoLoadEvent({
    required this.listOfTodo,
  });
}

final class OnAddTodoEvent extends TodoEvent {
  final String title;
  final String description;
  final Color color;
  final String category;

  OnAddTodoEvent({
    required this.title,
    required this.description,
    required this.color,
    required this.category,
  });
}

final class OnColorChangedEvent extends TodoEvent {
  final Color color;

  OnColorChangedEvent(this.color);
}

final class DropdownEvent extends TodoEvent {
  final String selectedValue;

  DropdownEvent({required this.selectedValue});
}
