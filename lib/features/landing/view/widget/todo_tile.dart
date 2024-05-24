
import 'package:flutter/material.dart';
import 'package:todo/common/color.dart';
import 'package:todo/features/landing/domain/model/todo_model.dart';

import '../../../../common/date_format.dart';

class NoteTile extends StatelessWidget {
  final NoteModel todo;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const NoteTile({
    required this.todo,
    required this.onDelete,
    required this.onEdit,
    super.key,
  });

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
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      todo.title,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: todo.color.computeLuminance() > 0.5
                            ? AppColor.blackColor
                            : AppColor.whiteColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onDelete,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.delete,
                        color: todo.color.computeLuminance() > 0.5
                            ? AppColor.blackColor
                            : AppColor.whiteColor,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      formatDate(todo.createdAt),
                      style: TextStyle(
                        color: todo.color.computeLuminance() > 0.5
                            ? AppColor.blackColor
                            : AppColor.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
