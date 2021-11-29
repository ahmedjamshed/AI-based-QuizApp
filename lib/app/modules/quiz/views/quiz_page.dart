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
  QuestionPage(this.position);
  final int position;
  RxInt selectedOption = RxInt(-1);
  @override
  Widget build(BuildContext context) {
    final question = controller.quizList[position].question;
    // final answer = controller.quizList[position].answer;
    final options = controller.quizList[position].options;

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
                  controller.pageController.next();
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
    // Mutiple words, one answer senetence with fill in the blank type mcq from sense2vec
    // Single option card flip and fill in the blanks with no sense2vec results
    // Single words from sense2vec not containg that word
    // https://towardsdatascience.com/practical-ai-automatically-generate-multiple-choice-questions-mcqs-from-any-content-with-bert-2140d53a9bf5
    return options
        .asMap()
        .map((i, option) => MapEntry(
            i,
            InkWell(
              onTap: () async {
                selectedOption.value = i;
                await Future.delayed(const Duration(seconds: 1));
                controller.pageController.next();
              },
              child: Obx(() => Option(
                  answer: option, isSelected: selectedOption.value == i)),
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
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isSelected
                ? Colors.amber.withOpacity(0.3)
                : Colors.transparent),
        child: Text(answer, style: Theme.of(context).textTheme.bodyText2));
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
