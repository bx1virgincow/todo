import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo/features/landing/view/bloc/note_bloc.dart';
import 'package:todo/features/landing/view/ui/landing_screen.dart';

import '../../../../common/color.dart';
import '../../../../common/widget/text_fields.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  //controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
      builder: (context, state) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.chevron_left,
                            )),
                        //row for color
                        Row(
                          children: [
                            //delete
                            InkWell(
                              onTap: () {
                                _titleController.clear();
                                _descriptionController.clear();
                              },
                              child: Icon(Icons.delete_outline, color: state.color,),
                            ),
                            //space
                            const SizedBox(width: 10),
                            //save
                            InkWell(
                              onTap: () {
                                BlocProvider.of<NoteBloc>(context).add(
                                  OnAddNoteEvent(
                                    title: _titleController.text,
                                    description: _descriptionController.text,
                                    color: state.color,
                                    category: state.dropdown,
                                  ),
                                );
                              },
                              child: Icon(Icons.save_outlined, color: state.color,),
                            ),
                            //space
                            const SizedBox(width: 10),
                            //color palette selector
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: SingleChildScrollView(
                                          child: ColorPicker(
                                            pickerColor:
                                                state is ColorPickerState
                                                    ? state.color
                                                    : Colors.blue,
                                            onColorChanged: (value) {
                                              // state.color = value;
                                              BlocProvider.of<NoteBloc>(context)
                                                  .add(
                                                OnColorChangedEvent(value),
                                              );
                                            },
                                            pickerAreaHeightPercent: 0.8,
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Icon(
                                Icons.palette_outlined,
                                color: state.color,
                              ),
                            ),
                          ],
                        )
                      ]),

                  //textfields
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
                ],
              ),
            ),
          ),
        ),
      ),
      listener: (BuildContext context, NoteState state) {
        if (state is TodoSuccessState) {
          _titleController.clear();
          _descriptionController.clear();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully Added'),
              backgroundColor: AppColor.backgroundColor,
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LandingScreen(),
            ),
          );
        }
      },
    );
  }
}
