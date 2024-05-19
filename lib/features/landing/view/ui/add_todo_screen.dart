import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo/common/app_texts.dart';
import 'package:todo/common/font.dart';
import 'package:todo/features/landing/view/bloc/note_bloc.dart';
import 'package:todo/features/landing/view/ui/landing_screen.dart';

import '../../../../common/color.dart';

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
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        pickerColor: state is ColorPickerState
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
                        )
                      ]),

                  //coding the [input] fields
                  TextFormField(
                    minLines: 2,
                    maxLines: 3,
                    controller: _titleController,
                    decoration: const InputDecoration(
                        hintText: AppTexts.addTitle,
                        hintStyle: TextStyle(
                          fontSize: AppFont.largerFontSize,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  ),
                  //height space
                  const SizedBox(height: 5),
                  //note description text-form-field
                  TextFormField(
                    controller: _descriptionController,
                    minLines: 2,
                    maxLines: 10,
                    decoration: const InputDecoration(
                        hintText: AppTexts.addDescription,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
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
                                  title: _titleController.text,
                                  description: _descriptionController.text,
                                  color: state.color,
                                  category: state.dropdown,
                                ),
                              );
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
