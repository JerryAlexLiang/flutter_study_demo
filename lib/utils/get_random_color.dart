import 'dart:math';

import 'package:flutter/material.dart';

getRandomColor() {
  return [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.amber,
    Colors.cyan,
    Colors.deepOrangeAccent,
    Colors.deepPurple,
    Colors.black,
    Colors.pinkAccent
  ][Random.secure().nextInt(9)];
}
