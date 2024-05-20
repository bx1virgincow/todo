import 'package:flutter/material.dart';
import 'package:todo/common/color.dart';
import 'package:todo/features/landing/domain/model/todo_model.dart';

class NoteTile extends StatelessWidget {
  final NoteModel todo;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const NoteTile(
      {required this.todo,
      required this.onDelete,
      required this.onEdit,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onEdit,
      child: Card(
        elevation: 4,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15),
          height: 120,
          decoration: BoxDecoration(
              color: todo.color,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColor.borderColor,
                width: 2,
                style: BorderStyle.solid,
              )),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(todo.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: todo.color.computeLuminance() > 0.5
                                ? AppColor.blackColor
                                : AppColor.whiteColor,
                          )),
                    ),
                    GestureDetector(
                      onTap: onDelete,
                      child: const Icon(Icons.delete),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(todo.description,
                    style: TextStyle(
                      color: todo.color.computeLuminance() > 0.5
                          ? AppColor.blackColor
                          : AppColor.whiteColor,
                    )),
                Text(todo.createdAt,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: todo.color.computeLuminance() > 0.5
                          ? AppColor.blackColor
                          : AppColor.whiteColor,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
