import 'package:get/get.dart';

import 'package:quizapp/app/modules/home/bindings/home_binding.dart';
import 'package:quizapp/app/modules/home/views/home_view.dart';
import 'package:quizapp/app/modules/quiz/bindings/quiz_binding.dart';
import 'package:quizapp/app/modules/quiz/views/quiz_view.dart';
import 'package:quizapp/app/modules/topic/bindings/topic_binding.dart';
import 'package:quizapp/app/modules/topic/views/topic_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TOPIC,
      page: () => TopicView(),
      binding: TopicBinding(),
    ),
    GetPage(
      name: _Paths.Quiz,
      page: () => QuizView(),
      binding: QuizBinding(),
    ),
  ];
}
