part of 'note_bloc.dart';

@immutable
sealed class NoteState {
  final NoteModel? todo;
  final List<NoteModel> noteList;
  final String errorMessage;
  final Color color;
  final String dropdown;
  final String searchValue;
  final bool isSearchClicked;

  const NoteState({
    required this.errorMessage,
    required this.noteList,
    required this.todo,
    required this.color,
    required this.dropdown,
    required this.searchValue,
    required this.isSearchClicked,
  });
}

class NoteInitial extends NoteState {
  const NoteInitial({
    super.errorMessage = "",
    super.noteList = const [],
    super.todo,
    super.color = Colors.blue,
    super.dropdown = '',
    super.searchValue = '',
    super.isSearchClicked = false,
  });
}

class NoteLoadedState extends NoteState {
  const NoteLoadedState({
    super.errorMessage = "",
    required super.noteList,
    super.todo,
    super.color = Colors.blue,
    super.dropdown = '',
    super.searchValue = '',
    super.isSearchClicked = false,
  });
}

class NoteAddedState extends NoteState {
  const NoteAddedState({
    super.errorMessage = "",
    required super.noteList,
    super.todo,
    super.color = Colors.blue,
    super.dropdown = '',
    super.searchValue = '',
    super.isSearchClicked = false,
  });
}

class NoteFailedState extends NoteState {
  const NoteFailedState({
    required super.errorMessage,
    super.noteList = const [],
    super.todo,
    super.color = Colors.blue,
    super.dropdown = '',
    super.searchValue = '',
    super.isSearchClicked = false,
  });
}

class TodoSuccessState extends NoteState {
  const TodoSuccessState({
    super.errorMessage = "",
    super.noteList = const [],
    super.todo,
    super.color = Colors.blue,
    super.dropdown = '',
    super.searchValue = '',
    super.isSearchClicked = false,
  });
}

class ColorPickerState extends NoteState {
  const ColorPickerState({
    super.errorMessage = "",
    super.noteList = const [],
    super.todo,
    required super.color,
    super.dropdown = '',
    super.searchValue = '',
    super.isSearchClicked = false,
  });
}

class DropdownState extends NoteState {
  const DropdownState({
    super.errorMessage = '',
    super.noteList = const [],
    super.todo,
    super.color = Colors.blue,
    required super.dropdown,
    super.searchValue = '',
    super.isSearchClicked = false,
  });
}

class NoteDeletedState extends NoteState {
  const NoteDeletedState({
    super.errorMessage = '',
    super.noteList = const [],
    super.todo,
    super.color = Colors.blue,
    super.dropdown = '',
    super.searchValue = '',
    super.isSearchClicked = false,
  });
}

class DeleteSuccessState extends NoteState {
  const DeleteSuccessState({
    super.errorMessage = '',
    super.noteList = const [],
    super.todo,
    super.color = Colors.blue,
    super.dropdown = '',
    super.searchValue = '',
    super.isSearchClicked = false,
  });
}

class DeleteFailedState extends NoteState {
  const DeleteFailedState({
    required super.errorMessage,
    super.noteList = const [],
    super.todo,
    super.color = Colors.blue,
    super.dropdown = '',
    super.searchValue = '',
    super.isSearchClicked = false,
  });
}

class SearchNoteState extends NoteState {
  const SearchNoteState({
    super.errorMessage = '',
    required super.noteList,
    super.todo,
    super.color = Colors.blue,
    super.dropdown = '',
    required super.searchValue,
    super.isSearchClicked = false,
  });
}

class UpdateNoteState extends NoteState {
  const UpdateNoteState({
    super.errorMessage="",
    super.noteList=const [],
    super.todo,
    super.color = Colors.blue,
    super.dropdown="",
    super.searchValue="",
    super.isSearchClicked = false,
  });
}

class OnOPenSearchBarState extends NoteState {
  const OnOPenSearchBarState({
    super.errorMessage="",
    super.noteList=const [],
    super.todo,
    super.color = Colors.blue,
    super.dropdown="",
    super.searchValue="",
    required super.isSearchClicked,
  });
}

