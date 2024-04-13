import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo/features/landing/view/bloc/note_bloc.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({
    super.key,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
  })  : _titleController = titleController,
        _descriptionController = descriptionController;

  final TextEditingController _titleController;
  final TextEditingController _descriptionController;

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) => AlertDialog(
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Add Task'),
                      GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close)),
                    ]),
                const Divider(),
                TextFormField(
                  controller: widget._titleController,
                  decoration: const InputDecoration(hintText: 'Title'),
                ),
                TextFormField(
                  controller: widget._descriptionController,
                  decoration: const InputDecoration(hintText: 'Description'),
                ),
                const SizedBox(height: 10),
                //dropdown

                //color picker
                ColorPicker(
                  pickerColor:
                      state is ColorPickerState ? state.color : Colors.blue,
                  onColorChanged: (value) {
                    state.color = value;
                    BlocProvider.of<NoteBloc>(context).add(
                      OnColorChangedEvent(value),
                    );
                  },
                  pickerAreaHeightPercent: 0.8,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<NoteBloc>(context).add(
                              OnAddNoteEvent(
                                title: widget._titleController.text,
                                description: widget._descriptionController.text,
                                color: state.color,
                                category: state.dropdown,
                              ),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text('Add')),
                    ),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('Clear')),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
