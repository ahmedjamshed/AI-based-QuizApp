import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/app/modules/quiz/controllers/quiz_controller.dart';
import 'package:quizapp/app/modules/quiz/views/quiz_page.dart';
import 'package:quizapp/app/modules/topic/views/drawer_view.dart';

const xOffset = 230.0;
const yOffset = 150.0;
const scaleFactor = 0.6;

const _duration = Duration(milliseconds: 250);

class QuizView extends GetView<QuizController> {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Time'),
          centerTitle: true,
        ),
        body: Row(
          children: [
            Flexible(child: QuizPage()),
          ],
        ));
  }
}
