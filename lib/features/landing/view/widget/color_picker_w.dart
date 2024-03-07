import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo/features/landing/view/bloc/todo_bloc.dart';

class ColorPickerWidget extends StatelessWidget {
  final ColorPicker colorPicker;
  const ColorPickerWidget({required this.colorPicker, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is ColorPickerState) {
          return Container(
            width: 30,
            height: 30,
            color: state.color,
          );
        } else {
          return Container(
            width: 30,
            height: 30,
            color: Colors.yellow,
          );
        }
      },
    );
  }
}
