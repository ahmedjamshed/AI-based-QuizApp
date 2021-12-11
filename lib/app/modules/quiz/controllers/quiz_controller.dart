import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:get/get.dart';
import 'package:quizapp/app/data/api_helper.dart';

class Question {
  final String question;
  final String answer;
  final String correct;
  final String context;
  final List<String> options;

  Question(
      this.question, this.answer, this.context, this.correct, this.options);
  factory Question.fromMap(dynamic json) {
    final correct = json['correct'] ?? 'No Answer';
    final List<String> options = json['options'].cast<String>()
      ..add(correct)
      ..shuffle();
    // for (final option in json['options']) {
    //   options.add(option);
    // }
    return Question(
        json['question'], json['answer'], json['context'], correct, options);
  }
}

class QuizController extends GetxController {
  final ApiHelper _apiHelper = Get.find();

  final RxList<Question> _dataList = RxList();
  List<Question> get quizList => _dataList;
  set quizList(List<Question> quizList) => _dataList.addAll(quizList);

  final RxBool _isLoading = true.obs;
  dynamic get isLoading => _isLoading;

  final pageController = IndexController();

  void generateQuestions(String content) {
    _isLoading.value = true;
    _apiHelper.generateQuestions(content).futureValue((dynamic value) {
      quizList = value['questions']
          .map<Question>((val) => Question.fromMap(val))
          .toList();
      _isLoading.value = false;
    });
  }

  @override
  void onReady() {
    super.onReady();
    final content = Get.arguments;
    generateQuestions(content);
  }
}
