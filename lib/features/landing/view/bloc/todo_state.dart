part of 'todo_bloc.dart';

@immutable
sealed class TodoState {
   TodoModel? todo;
   List<TodoModel> listOfTodo;
   String errorMessage;
   Color color;

   TodoState({
    required this.errorMessage,
    required this.listOfTodo,
    required this.todo,
    required this.color,
  });
}

 class TodoInitial extends TodoState {
   TodoInitial({
    super.errorMessage = "",
    super.listOfTodo = const [],
    super.todo,
    super.color = Colors.blue,
  });
}

 class TodoLoaded extends TodoState {
   TodoLoaded({
    super.errorMessage = "",
    required super.listOfTodo,
    super.todo,
    super.color= Colors.blue,
  });
}

class TodoAdded extends TodoState {
  TodoAdded({
    super.errorMessage = "",
    required super.listOfTodo,
    super.todo,
    super.color= Colors.blue,
  });
}

 class TodoFailed extends TodoState {
   TodoFailed({
    required super.errorMessage,
    super.listOfTodo = const [],
    super.todo,
    super.color = Colors.blue,
  });
}

 class TodoSuccessState extends TodoState {
   TodoSuccessState({
    super.errorMessage = "",
    super.listOfTodo = const [],
    super.todo,
    super.color = Colors.blue,
  });
}

 class ColorPickerState extends TodoState {
  ColorPickerState({
    super.errorMessage="",
    super.listOfTodo=const [],
    super.todo,
    required super.color,
  });
}
