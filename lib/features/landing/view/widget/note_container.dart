import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo/features/landing/view/widget/todo_tile.dart';

import '../../domain/model/todo_model.dart';
import '../bloc/note_bloc.dart';

class NoteWidget extends StatelessWidget {
  final List<NoteModel> noteList;
  const NoteWidget({required this.noteList, super.key});

  //bloc instance
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: noteList.length,
      itemBuilder: (BuildContext context, int index) => NoteTile(
          todo: noteList[index],
          onDelete: () {
            context.read<NoteBloc>().add(
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
