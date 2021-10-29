import 'package:get/get.dart';
import 'package:quizapp/app/data/api_helper.dart';

class Topic {
  dynamic page;
  dynamic topics;
  Topic({this.page, this.topics});
}

class TopicController extends GetxController {
  final ApiHelper _apiHelper = Get.find();

  final Rx<Topic> _topic = Topic().obs;
  Topic get topic => _topic.value;
  set topic(Topic topic) => _topic.value = topic;

  void getTopic(String id) {
    _apiHelper.getTopic(id).futureValue(
          (dynamic value) => topic = value,
        );
  }
}
