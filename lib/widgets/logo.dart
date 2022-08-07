import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double? size;
  const Logo({required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      'TMD',
      style: TextStyle(
          fontSize: size, color: Colors.yellow, fontWeight: FontWeight.bold),
    );
  }
}
