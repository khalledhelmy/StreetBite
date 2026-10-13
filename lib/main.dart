import 'package:flutter/material.dart';

void main() {
  runApp(const StreetBite());
}

class StreetBite extends StatelessWidget {
  const StreetBite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'StreetBite', home: Scaffold());
  }
}
