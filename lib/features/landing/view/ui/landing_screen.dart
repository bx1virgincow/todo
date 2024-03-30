import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo/features/landing/view/bloc/todo_bloc.dart';
import 'package:todo/features/landing/view/widget/todo_tile.dart';

import '../widget/add_todo.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  //controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  //dispose
  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBloc, TodoState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Phish Todo'),
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddTodo(
                                titleController: _titleController,
                                descriptionController: _descriptionController);
                          });
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            //body
            body: (state is TodoInitial)
                ? const CircularProgressIndicator()
                : (state is TodoLoaded)
                    ? ListView.builder(
                        itemCount: state.listOfTodo.length,
                        itemBuilder: (context, index) => RefreshIndicator(
                          onRefresh: () async => context
                              .read<TodoBloc>()
                              .add(OnTodoLoadEvent(listOfTodo: [])),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TodoTile(
                              todo: state.listOfTodo[index],
                            ),
                          ),
                        ),
                      )
                    : (state is TodoFailed)
                        ? const Text('Failed to fetch data')
                        : const SizedBox());
      },
      listener: (BuildContext context, TodoState state) {
        if (state is TodoSuccessState) {
          _titleController.clear();
          _descriptionController.clear();

          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully Added')),
          );
        }
      },
    );
  }
}
