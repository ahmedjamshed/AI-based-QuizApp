import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
export 'package:quizapp/app/common/util/extensions.dart';
import 'package:get/get.dart';
import 'package:quizapp/app/modules/quiz/controllers/quiz_controller.dart';
import 'package:quizapp/app/routes/app_pages.dart';
import 'package:percent_indicator/percent_indicator.dart';

class QuestionPage extends GetView<QuizController> {
  QuestionPage(this.position);
  final int position;
  @override
  Widget build(BuildContext context) {
    final item = controller.quizList[position];
    final total = controller.quizList.length;
    final question = item.question;
    // final answer = controller.quizList[position].answer;
    final answer = item.answer;
    final options = item.options;
    final cheatText = item.context;

    return Container(
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    '${position + 1} / $total',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Cheat Context',
                        middleText: cheatText,
                        titleStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                        middleTextStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        textConfirm: 'Ok',
                        buttonColor: Theme.of(context).primaryColor,
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          Get.back();
                        },
                      );
                    },
                    color: Theme.of(context).primaryColor,
                    icon: const Icon(
                      Icons.vpn_key_sharp,
                      size: 30,
                    )),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ignore: prefer_if_elements_to_conditional_expressions

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Q) $question',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ),
                      // Text(question, style: Theme.of(context).textTheme.headline4),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('A) $answer',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                      Wrap(children: [...getOptions(options, context)])
                    ]),
              ),
            ),
          ],
        ));
  }

  List<Widget> getOptions(List<String> options, BuildContext context) {
    return options
        .asMap()
        .map((i, option) => MapEntry(
            i,
            InkWell(
              onTap: () async {
                controller.markAnswer(position, option);
                await Future.delayed(const Duration(milliseconds: 500));
                controller.pageController.next();
              },
              child: Obx(() => Option(
                  answer: '${i + 1}) ${option.capitalizeFirst}',
                  isSelected: controller.isSelected(position, option))),
            )))
        .values
        .toList();
  }
}

class Option extends StatelessWidget {
  final String answer;
  final bool isSelected;
  const Option({Key? key, required this.answer, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(7),
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor.withOpacity(0.3)
                : Colors.transparent,
            border: Border.all(color: Theme.of(context).primaryColor, width: 2),
            borderRadius: BorderRadius.circular(15)),
        child: Text(answer,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15)));
  }
}

class ResultPage extends GetView<QuizController> {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final result = controller.calulateResult();
    final int resultPer = (result * 100).round();
    MaterialColor color = Colors.red;
    String header = "Alas";
    String footer = "Better luck next time!";
    if (resultPer >= 70) {
      color = Colors.green;
      header = "Excellent";
      footer = "Keep it up!";
    } else if (resultPer >= 40) {
      color = Colors.amber;
      header = "Sigh";
      footer = "You can do better!";
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.school_sharp,
            color: Theme.of(context).primaryColor,
            size: 200.0,
          ),
          CircularPercentIndicator(
            radius: 180.0,
            lineWidth: 28.0,
            animation: true,
            percent: result,
            animationDuration: 1500,
            header: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                header,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 28.0),
              ),
            ),
            center: Text(
              '$resultPer%',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            footer: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                footer,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 26.0),
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: color,
          ),
          const Spacer()
        ],
      ),
    );
  }
}
