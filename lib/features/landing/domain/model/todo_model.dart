// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TodoModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final Color color;
  final String category;

  const TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.category,
  });

  @override
  List<Object> get props => [
        id,
        title,
        description,
        color,
        category,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'color': color.value, // Convert Color to int for storage
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      color: Color(map['color'] as int),
      category: map['category'] as String, // Convert int to Color
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      color: Color(json['color'] as int),
      category: json['category'] as String, // Convert int to Color
    );
  }

  String toJson() => json.encode(toMap());
}
