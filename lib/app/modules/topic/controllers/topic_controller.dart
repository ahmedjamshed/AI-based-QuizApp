import 'package:get/get.dart';
import 'package:quizapp/app/data/api_helper.dart';

class TopicController extends GetxController {
  final ApiHelper _apiHelper = Get.find();

  final _topic = {}.obs;
  dynamic get topic => _topic;
  set topic(dynamic topic) => _topic.value = topic;

  final RxBool _isLoading = true.obs;
  dynamic get isLoading => _isLoading;

  void getTopic(String id) {
    _isLoading.value = true;
    _apiHelper.getTopic(id).futureValue((dynamic value) {
      topic = value;
      _isLoading.value = false;
    });
  }

  @override
  void onReady() {
    super.onReady();
    final id = Get.arguments[0];
    getTopic(id);
  }

  @override
  void onClose() {
    super.onClose();
    print('close');
  }
}
