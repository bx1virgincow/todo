


import 'package:flutter/material.dart';
import 'package:todo/features/landing/domain/model/todo_model.dart';

class StatusTile extends StatelessWidget {
  final TodoModel? todoModel;
  const StatusTile({
    super.key,
    required this.todoModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue,
            borderRadius: BorderRadius.circular(20)
        ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(50)
            ),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('On Going'),
              Text('23 Task'),
            ],
          )
        ],
      ),
    );
  }
}
