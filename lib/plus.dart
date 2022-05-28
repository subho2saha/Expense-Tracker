import 'package:flutter/material.dart';

class plusbutton extends StatelessWidget {
  final function;
  plusbutton({this.function});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: function,
    child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text("+", style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Ubuntu'),
              ),
            ),
            ),
    );
  }
}