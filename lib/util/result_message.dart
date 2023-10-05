// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:math_game_app/constants.dart';

class ResultMessage extends StatelessWidget {
  final String message;
  final VoidCallback onTap;
  final icon;
  const ResultMessage({
    super.key,
    required this.message,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      content: Container(
        height: 200,
        color: Colors.deepPurple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // the result
            Text(
              message,
              style: whiteTextStyle,
            ),

            // the button to go to next question
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
