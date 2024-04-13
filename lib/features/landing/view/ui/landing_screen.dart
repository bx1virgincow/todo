import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/color.dart';
import '../../domain/model/todo_model.dart';
import '../bloc/note_bloc.dart';
import '../widget/add_todo.dart';
import '../widget/todo_tile.dart';
import 'edit_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final NoteBloc _noteBloc = NoteBloc();

  @override
  void initState() {
    super.initState();
    _noteBloc.add(OnNoteLoadEvent(listOfTodo: const []));
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddTodo(
              titleController: _titleController,
              descriptionController: _descriptionController,
            );
          },
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
              return _buildLoadedStateUI(state);
            } else if (state is NoteFailedState) {
              return const Text('Failed to fetch data');
            } else {
              return const SizedBox();
            }
          },
          listener: (BuildContext context, NoteState state) {
            if (state is TodoSuccessState) {
              _titleController.clear();
              _descriptionController.clear();

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Successfully Added'),
                  backgroundColor: AppColor.backgroundColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadedStateUI(NoteLoadedState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Row(
            children: [
              CircleAvatar(),
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi Bruce'),
                  Text('Your daily adventure starts now')
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<List<TodoModel>>(
              stream: _noteBloc.noteStream,
              builder: (context, snapshot) {
                log('snapshot data: ${snapshot.data}');
                log('noteStream: ${_noteBloc.noteStream}');
                log('notes: ${state.listOfTodo}');
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text(
                      'No To Do Available\nClick on the "+" to add a new todo',
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return TodoTile(
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditScreen(
                                todoModel: snapshot.data![index],
                              ),
                            ),
                          );
                        },
                        todo: snapshot.data![index],
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
