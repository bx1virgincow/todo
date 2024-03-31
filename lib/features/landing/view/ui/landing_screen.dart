import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/common/color.dart';
import 'package:todo/features/landing/view/bloc/todo_bloc.dart';
import 'package:todo/features/landing/view/widget/todo_tile.dart';

import '../widget/add_todo.dart';
import '../widget/status_tile.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  //controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  //instance of bloc
  final TodoBloc _todoBloc = TodoBloc();

  //init state
  @override
  void initState() {
    super.initState();
    _todoBloc.add(OnTodoLoadEvent(listOfTodo: const []));
  }

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
      bloc: _todoBloc,
      builder: (context, state) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddTodo(
                        titleController: _titleController,
                        descriptionController: _descriptionController);
                  }),
              child: const Icon(Icons.add),
            ),
            //body
            body: SafeArea(
              child: (state is TodoInitial)
                  ? const Center(child: CircularProgressIndicator())
                  : (state is TodoLoaded)
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  CircleAvatar(),
                                  SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Hi Bruce'),
                                      Text('Your daily adventure starts now')
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              //status
                              Flexible(
                                  child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return StatusTile(
                                    todoModel: state.todo,
                                  );
                                },
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 80,
                                  mainAxisSpacing: 10,
                                ),
                              )),

                              //todo
                              const SizedBox(height: 10),
                              (state.listOfTodo.isEmpty)
                                  ? const Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              'No To Do Available\nClick on the "+" to add a new todo')
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView.builder(
                                        itemCount: state.listOfTodo.length,
                                        itemBuilder: (context, index) =>
                                            RefreshIndicator(
                                          onRefresh: () async => context
                                              .read<TodoBloc>()
                                              .add(OnTodoLoadEvent(
                                                  listOfTodo:
                                                      state.listOfTodo)),
                                          child: TodoTile(
                                            todo: state.listOfTodo[index],
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        )
                      : (state is TodoFailed)
                          ? const Text('Failed to fetch data')
                          : const SizedBox(),
            ));
      },
      listener: (BuildContext context, TodoState state) {
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
    );
  }
}
