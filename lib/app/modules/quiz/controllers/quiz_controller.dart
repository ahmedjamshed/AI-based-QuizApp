import 'package:get/get.dart';
import 'package:quizapp/app/data/api_helper.dart';

class QuizController extends GetxController {
  final ApiHelper _apiHelper = Get.find();

  final RxList _quizList = RxList();
  List<dynamic> get quizList => _quizList;
  set quizList(List<dynamic> quizList) => _quizList.addAll(quizList);

  final RxBool _isLoading = true.obs;
  dynamic get isLoading => _isLoading;

  void generateQuestions(String content) {
    _isLoading.value = true;
    _apiHelper.generateQuestions(content).futureValue((dynamic value) {
      quizList = value['questions'];
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
