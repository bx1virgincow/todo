import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo/features/landing/view/bloc/todo_bloc.dart';
import 'package:todo/features/landing/view/widget/todo_tile.dart';

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
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Add Task'),
                                      const Divider(),
                                      TextFormField(
                                        controller: _titleController,
                                        decoration: const InputDecoration(
                                            hintText: 'Title'),
                                      ),
                                      TextFormField(
                                        controller: _descriptionController,
                                        decoration: const InputDecoration(
                                            hintText: 'Description'),
                                      ),
                                      const SizedBox(height: 10),
                                      //color picker
                                      ColorPicker(
                                        pickerColor: state.color,
                                        onColorChanged: (value) {
                                          log('Selected color: $value');
                                          BlocProvider.of<TodoBloc>(context)
                                              .add(
                                            OnColorChangedEvent(value),
                                          );
                                        },
                                        pickerAreaHeightPercent: 0.8,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  BlocProvider.of<TodoBloc>(
                                                          context)
                                                      .add(
                                                    OnAddTodoEvent(
                                                      title:
                                                          _titleController.text,
                                                      description:
                                                          _descriptionController
                                                              .text,
                                                      color: state.color,
                                                    ),
                                                  );
                                                },
                                                child: const Text('Add')),
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  BlocProvider.of<TodoBloc>(
                                                          context)
                                                      .add(OnTodoLoadEvent(
                                                          listOfTodo: []));
                                                },
                                                child: const Text('Clear')),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
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
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TodoTile(
                            todo: state.listOfTodo[index],
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
