import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/common/widget/text_fields.dart';
import 'package:todo/features/landing/domain/model/todo_model.dart';

import '../bloc/note_bloc.dart';

class EditScreen extends StatefulWidget {
  final NoteModel todoModel;
  const EditScreen({super.key, required this.todoModel});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  //controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.todoModel.title;
    _descriptionController.text = widget.todoModel.description;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //back arrow
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.chevron_left),
                        )
                      ],
                    ),
                    //space
                    const SizedBox(height: 20),

                    //todo: title form fields
                    TextFields(
                      controller: _titleController,
                      hintText: 'Title',
                      keyboardType: TextInputType.text,
                    ),

                    //space
                    const SizedBox(height: 10),

                    //todo: description form field
                    TextFields(
                      minLine: 2,
                      maxLine: 10,
                      maxLength: 1000,
                      controller: _descriptionController,
                      hintText: 'Description',
                      keyboardType: TextInputType.multiline,
                    ),

                    //space
                    const SizedBox(height: 10),

                    //button
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<NoteBloc>().add(
                                OnUpdateNoteEvent(
                                  id: widget.todoModel.id,
                                  title: _titleController.text,
                                  description: _descriptionController.text,
                                  color: widget.todoModel.color,
                                  category: state.dropdown,
                                ),
                              );
                        },
                        child: const Text('Update Note'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
