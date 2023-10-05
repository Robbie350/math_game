// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_game_app/constants.dart';
import 'package:math_game_app/util/my_button.dart';
import 'package:math_game_app/util/result_message.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // number pad list

  List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '=',
    '0',
  ];

  // number A, number B
  int numberA = 1;
  int numberB = 2;

  // user answer

  String userAnswer = '';

  // button tapped method
  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        // calculate if the user is correct or not

        checkResult();
      } else if (button == 'C') {
        userAnswer = '';
      } else if (button == 'DEL') {
        // deletes the last character
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } // max 3 you can input
      else if (userAnswer.length < 3) {
        userAnswer += button;
      }
    });
  }

  // method to chech if the user is correct
  void checkResult() {
    if (numberA + numberB == int.parse(userAnswer)) {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'Correct!',
              onTap: goToNextQuestoin,
              icon: Icons.forward,
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'InCorrect!',
              onTap: goBackToQuestion,
              icon: Icons.rotate_left,
            );
          });
    }
  }

  // create a random numbers
  var randomNumber = Random();

  // go to the next questoin method

  void goToNextQuestoin() {
    // dismiss the dialog
    Navigator.of(context).pop();

    // reset the values
    setState(() {
      userAnswer = '';
    });

    // create a new question

    numberA = randomNumber.nextInt(10);
    numberB = randomNumber.nextInt(50);
  }

  // go back to previous questoin method

  void goBackToQuestion() {
    // dismiss the alert dialog
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: Column(
        children: [
          // level progress, player need 5 correct answers in a row to get to another level
          Container(
            height: 160,
            color: Colors.deepPurple,
          ),

          // question
          Expanded(
            child: Container(
              color: Colors.deepPurple[300],
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // question
                    Text(
                      '$numberA + $numberB = ',
                      style: whiteTextStyle,
                    ),

                    // answer box
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[400],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          userAnswer,
                          style: whiteTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // number pad
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                itemCount: numberPad.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return SafeArea(
                    child: MyButton(
                      child: numberPad[index],
                      onTap: () => buttonTapped(
                        numberPad[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
