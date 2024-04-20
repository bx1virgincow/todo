// import 'package:flutter/material.dart';
//
// import '../../domain/model/task_type.dart';
// import '../bloc/note_bloc.dart';
//
//
//
// DropdownButton<String>(
// isExpanded: true,
// value: state is DropdownState ? state.dropdown : 'active',
// onChanged: (value) {
// if (state is DropdownState) {
// state.dropdown = value as String;
// }
// context
//     .read<TodoBloc>()
//     .add(DropdownEvent(selectedValue: value as String));
// },
// items: taskStatus
//     .map((item) => DropdownMenuItem<String>(
// value: item.value,
// child: Text(item.title),
// ))
//     .toList(),
// ),
// const SizedBox(height: 10),