import 'package:flutter/material.dart';
import 'package:todo/features/landing/domain/model/todo_model.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todo;
  const TodoTile({required this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: todo.color,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(todo.title),
          Text(todo.description)
        ],
      ),
    );
  }
}