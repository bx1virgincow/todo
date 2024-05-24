import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo/common/color.dart';
import 'package:todo/common/date_format.dart';
import 'package:todo/common/widget/text_fields.dart';
import 'package:todo/features/landing/domain/model/todo_model.dart';
import 'package:todo/features/landing/view/ui/landing_screen.dart';

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
  late Color _color;
  @override
  void initState() {
    _titleController.text = widget.todoModel.title;
    _descriptionController.text = widget.todoModel.description;
    _color = widget.todoModel.color;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //back arrow
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,height: 40,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: AppColor.backgroundColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Icon(
                          Icons.chevron_left,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),

                    //color palette
                    Row(
                      children: [
                        //save icon
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<NoteBloc>(context).add(
                              OnUpdateNoteEvent(
                                id: widget.todoModel.id,
                                title: _titleController.text,
                                description: _descriptionController.text,
                                color: _color,
                              ),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Note Updated Successfully!'),
                              ),
                            );

                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => LandingScreen()),
                                  (Route<dynamic> route) => false,
                            );
                          },
                          child: Container(
                            width: 40, height: 40,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: AppColor.backgroundColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              Icons.update_outlined,
                              color: AppColor.whiteColor,
                            ),
                          ),
                        ),
                        //space
                        const SizedBox(width: 10),
                        //color palette
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        pickerColor: _color,
                                        onColorChanged: (value) {
                                          _color = value;
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
                          child: Container(
                            width: 40, height: 40,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: AppColor.backgroundColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              Icons.palette_outlined,
                              color: AppColor.whiteColor,
                            ),
                          ),
                        ),
                      ],
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
                const SizedBox(height: 5),
                Text(
                  'Created At: ${formatDate(widget.todoModel.createdAt)}',
                  style: TextStyle(color: AppColor.backgroundColor),
                ),

                //space
                const SizedBox(height: 10),

                //todo: description form field
                TextFields(
                  minLine: 2,
                  maxLine: 10,
                  // maxLength: 1000,
                  controller: _descriptionController,
                  hintText: 'Description',
                  keyboardType: TextInputType.multiline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
