// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NoteModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final Color color;
  final String createdAt;

  const NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.createdAt,
  });

  @override
  List<Object> get props => [
        id,
        title,
        description,
        color,
        createdAt,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'color': color.value, // Convert Color to int for storage
      'createdAt': createdAt,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      color: Color(map['color'] as int),// Convert int to Color
      createdAt: map['createdAt'] as String,
    );
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      color: Color(json['color'] as int), // Convert int to Color
      createdAt: json['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
