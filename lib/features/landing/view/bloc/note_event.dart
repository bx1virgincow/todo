part of 'note_bloc.dart';

@immutable
sealed class TodoEvent {}

final class OnNoteLoadEvent extends TodoEvent {
  final List<TodoModel> listOfTodo;

  OnNoteLoadEvent({
    required this.listOfTodo,
  });
}

final class OnAddNoteEvent extends TodoEvent {
  final String title;
  final String description;
  final Color color;
  final String category;

  OnAddNoteEvent({
    required this.title,
    required this.description,
    required this.color,
    required this.category,
  });
}

final class OnUpdateNoteEvent extends TodoEvent {
  final int id;
  final String title;
  final String description;
  final Color color;
  final String category;

  OnUpdateNoteEvent({
    required this.id,
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
