import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../bloc/note_bloc.dart';


class ColorPickerWidget extends StatelessWidget {
  final ColorPicker colorPicker;
  const ColorPickerWidget({required this.colorPicker, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
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
