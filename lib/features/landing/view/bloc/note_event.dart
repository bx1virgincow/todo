part of 'note_bloc.dart';

@immutable
sealed class NoteEvent {}

final class OnNoteLoadEvent extends NoteEvent {
  final List<NoteModel> noteList;

  OnNoteLoadEvent({
    required this.noteList,
  });
}

final class OnDeleteNoteEvent extends NoteEvent {
  final int noteId;
  OnDeleteNoteEvent(this.noteId);
}

final class OnAddNoteEvent extends NoteEvent {
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

final class OnUpdateNoteEvent extends NoteEvent {
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

final class SearchNoteEvent extends NoteEvent {
  final String searchValue;

  SearchNoteEvent({required this.searchValue});
}

final class FilterNoteEvent extends NoteEvent {
  final Color color;
  FilterNoteEvent({required this.color});
}

final class OnColorChangedEvent extends NoteEvent {
  final Color color;

  OnColorChangedEvent(this.color);
}

final class DropdownEvent extends NoteEvent {
  final String selectedValue;

  DropdownEvent({required this.selectedValue});
}

final class NavigateToHomePage extends NoteEvent {}
