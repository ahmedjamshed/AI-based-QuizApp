import 'dart:ui';

import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quizapp/app/modules/quiz/controllers/quiz_controller.dart';
import 'package:quizapp/app/routes/app_pages.dart';

class DeepthPageTransformer extends PageTransformer {
  DeepthPageTransformer() : super(reverse: true);

  @override
  Widget transform(Widget child, TransformInfo info) {
    final double position = info.position ?? 0.0;
    if (position <= 0) {
      return Opacity(
        opacity: (position + 1.0).abs(),
        child: child,
      );
    } else if (position <= 1) {
      return Opacity(
        opacity: 1.0 - position,
        child: child,
      );
    }
    return child;
  }
}

class QuestionPage extends GetView<QuizController> {
  const QuestionPage(this.position);
  final int position;
  @override
  Widget build(BuildContext context) {
    final question = controller.quizList[position].question;
    // final answer = controller.quizList[position].answer;
    final options = controller.quizList[position].options;

    final selected

    return Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(children: [
          // ignore: prefer_if_elements_to_conditional_expressions
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black, padding: const EdgeInsets.all(8)),
                onPressed: () {
                  // Get.toNamed(Routes.QUIZ, arguments: description);
                  controller.pageController.previous();
                },
                child: const Text('Skip'),
              )
            ],
          ),
          Text(question, style: Theme.of(context).textTheme.headline4),
          ...getOptions(options, context),
        ]));
  }

  List<Widget> getOptions(List<String> options, BuildContext context) {
    return options
        .map((answer) =>
            Option())
        .toList();
  }
}

class Option extends StatelessWidget {
  const Option({
    Key? key,
    this.answer
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(answer, style: Theme.of(context).textTheme.bodyText2);
  }
}

class QuizPage extends GetView<QuizController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Obx(() => controller.isLoading.value
          ? const Text('loading')
          : TransformerPageView(
              // allowImplicitScrolling: true,
              controller: controller.pageController,
              onPageChanged: (index) {
                // controller.gotoPage(index ?? 0);
              },
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              transformer: DeepthPageTransformer(),
              itemCount: controller.quizList.length,
              itemBuilder: (context, position) {
                return QuestionPage(position);
              })),
    ));
  }
}
