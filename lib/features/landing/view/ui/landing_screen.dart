import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo/features/landing/data/local/local_note_repo_impl.dart';
import 'package:todo/features/landing/view/widget/todo_tile.dart';

import '../../../../common/color.dart';
import '../bloc/note_bloc.dart';
import 'add_todo_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final NoteBloc _noteBloc = NoteBloc(LocalNoteRepoImpl());

  @override
  void initState() {
    super.initState();
    _noteBloc.add(OnNoteLoadEvent(noteList: const []));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddTodo()),
        ),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
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
                      _noteBloc
                          .add(OnDeleteNoteEvent(state.noteList[index].id));
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
      ),
    );
  }
}
