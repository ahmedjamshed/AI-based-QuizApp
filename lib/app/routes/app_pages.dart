import 'package:get/get.dart';

import 'package:quizapp/app/modules/home/bindings/home_binding.dart';
import 'package:quizapp/app/modules/home/views/home_view.dart';
import 'package:quizapp/app/modules/labels/bindings/labels_binding.dart';
import 'package:quizapp/app/modules/labels/views/labels_view.dart';
import 'package:quizapp/app/modules/quiz/bindings/quiz_binding.dart';
import 'package:quizapp/app/modules/quiz/views/quiz_view.dart';
import 'package:quizapp/app/modules/topic/bindings/topic_binding.dart';
import 'package:quizapp/app/modules/topic/views/topic_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.TOPIC;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LABELS,
      page: () => LabelsView(),
      binding: LabelsBinding(),
    ),
    GetPage(
        name: _Paths.TOPIC,
        page: () => const TopicView(),
        binding: TopicBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: _Paths.QUIZ,
        page: () => QuizView(),
        binding: QuizBinding(),
        fullscreenDialog: true),
  ];
}
