import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/app/modules/quiz/controllers/quiz_controller.dart';
import 'package:quizapp/app/modules/quiz/views/quiz_page.dart';
import 'package:quizapp/app/modules/topic/views/drawer_view.dart';
import 'package:another_transformer_page_view/another_transformer_page_view.dart';

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
              physics: const NeverScrollableScrollPhysics(),
              curve: Curves.fastOutSlowIn,
              transformer: DeepthPageTransformer(),
              itemCount: controller.quizList.length + 1,
              itemBuilder: (context, position) {
                return controller.quizList.length == position
                    ? const ResultPage()
                    : QuestionPage(position);
              })),
    ));
  }
}

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
