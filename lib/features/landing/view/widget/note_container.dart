import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo/common/color.dart';
import 'package:todo/features/landing/view/ui/edit_screen.dart';
import 'package:todo/features/landing/view/widget/todo_tile.dart';

import '../../domain/model/todo_model.dart';
import '../bloc/note_bloc.dart';

class NoteWidget extends StatelessWidget {
  final List<NoteModel> noteList;
  final NoteBloc noteBloc;
  const NoteWidget({
    required this.noteList,
    required this.noteBloc,
    super.key,
  });

  //bloc instance
  @override
  Widget build(BuildContext context) {
    return noteList.isEmpty ? Center(
      child: RichText(
        text: const TextSpan(children:[
          TextSpan(text: 'Click on the', style: TextStyle(color: AppColor.blackColor)),
          TextSpan(text: '  +  ',style: TextStyle(fontSize: 20,color: AppColor.tabForegroundColor)),
          TextSpan(text: 'to add a new note',style: TextStyle(color: AppColor.blackColor))
        ]),
      ),
    ) : StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: noteList.length,
      itemBuilder: (BuildContext context, int index) => NoteTile(
          todo: noteList[index],
          onEdit: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditScreen(
                  todoModel: noteList[index],
                ),
              ),
            );
          },
          onDelete: () {
            noteBloc.add(
              OnDeleteNoteEvent(noteList[index].id),
            );
          }),
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 2 : 1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
