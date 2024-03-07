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

  OnAddTodoEvent({
    required this.title,
    required this.description,
    required this.color,
  });
}

final class OnColorChangedEvent extends TodoEvent{
  final Color color;

   OnColorChangedEvent(this.color);
}