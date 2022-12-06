import 'package:flutter/material.dart';

const primary = Color.fromRGBO(188, 26, 27, 1);
const primaryDark = Color.fromRGBO(182, 0, 1, 1);
const accent = Color.fromRGBO(245, 4, 13, 1);

const g1 = Color.fromRGBO(255, 46, 98, 1);
const g2 = Color.fromRGBO(195, 0, 29, 1);

const stroke = Color.fromRGBO(240, 240, 240, 1);
const btnBlack = Color.fromRGBO(67, 67, 67, 1);
const hintColor = Color.fromRGBO(167, 166, 167, 1);
const background = Color.fromRGBO(248, 248, 248, 1);
const lightWhite = Color.fromRGBO(246, 246, 246, 1);

final List<Color> boxColors = [primary, primaryDark];

const LinearGradient gradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [g1, g2],
);

const List<LinearGradient> gradients = [
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(0, 212, 255, 1), Color.fromRGBO(9, 9, 121, 1)],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(253, 29, 29, 1), Color.fromRGBO(252, 176, 69, 1)],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(253, 187, 45, 1),Color.fromRGBO(34, 193, 195, 1)],
  )
];
