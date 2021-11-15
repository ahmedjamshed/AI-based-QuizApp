import 'package:get/get.dart';
import 'package:quizapp/app/data/api_helper.dart';
import 'package:quizapp/app/modules/labels/controllers/labels_controller.dart';

class TopicController extends GetxController {
  final ApiHelper _apiHelper = Get.find();

  final _topic = {}.obs;
  dynamic get topic => _topic;
  set topic(dynamic topic) => _topic.value = topic;

  final RxBool _isLoading = true.obs;
  dynamic get isLoading => _isLoading;

  void getTopic(String title) {
    _isLoading.value = true;
    _apiHelper.getTopic(title).futureValue((dynamic value) {
      topic = value;
      _isLoading.value = false;
    });
  }

  @override
  void onReady() {
    super.onReady();
    final Label data = Get.arguments;
    getTopic(data.name);
  }

  @override
  void onClose() {
    super.onClose();
    print('close');
  }
}
