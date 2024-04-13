// Function to get gradient based on todo status
import 'package:flutter/material.dart';

LinearGradient getGradientFromColors(List<Color> colors) {
  return LinearGradient(
    colors: colors,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
