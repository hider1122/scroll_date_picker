// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';

class DatePickerOptions {
  const DatePickerOptions({
    this.itemExtent = 30.0,
    this.diameterRatio = 3,
    this.perspective = 0.01,
    this.isLoop = true,
    this.backgroundColor = Colors.white,
    this.backgroundOpacity = 0.15,
    this.borderRadius,
  });

  /// Size of each child in the main axis
  final double itemExtent;

  /// {@macro flutter.rendering.wheelList.diameterRatio}
  final double diameterRatio;

  /// {@macro flutter.rendering.wheelList.perspective}
  final double perspective;

  /// The loop iterates on an explicit list of values
  final bool isLoop;

  /// The color to paint behind the date picker
  final Color backgroundColor;

  /// The opacity behind the date picker
  final double backgroundOpacity;

  /// The borderRadius behind the date picker
  final BorderRadiusGeometry? borderRadius;
}
