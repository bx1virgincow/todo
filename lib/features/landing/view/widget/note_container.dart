import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo/features/landing/data/local/local_note_repo_impl.dart';
import 'package:todo/features/landing/view/widget/todo_tile.dart';

import '../../../../common/color.dart';
import '../bloc/note_bloc.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({super.key});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  //bloc instance
  final NoteBloc _noteBloc = NoteBloc(LocalNoteRepoImpl());

  @override
  void initState() {
    super.initState();
    _noteBloc.add(OnNoteLoadEvent(noteList: const []));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<NoteBloc, NoteState>(
        bloc: _noteBloc,
        builder: (context, state) {
          if (state is NoteInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoteLoadedState) {
            return StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: state.noteList.length,
              itemBuilder: (BuildContext context, int index) => NoteTile(
                  todo: state.noteList[index],
                  onDelete: () {
                    _noteBloc.add(
                      OnDeleteNoteEvent(state.noteList[index].id),
                    );
                  }),
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.count(2, index.isEven ? 2 : 1),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            );
          } else if (state is NoteFailedState) {
            return const Text('Failed to fetch data');
          } else {
            return const SizedBox();
          }
        },
        listener: (BuildContext context, NoteState state) {
          if (state is NoteDeletedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Deleted Successfully!'),
                  backgroundColor: AppColor.backgroundColor),
            );
          }
        },
      ),
    );
  }
}
