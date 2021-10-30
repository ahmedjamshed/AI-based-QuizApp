import 'package:get/get.dart';
import 'package:quizapp/app/modules/topic/controllers/topic_controller.dart';

class TopicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopicController>(
      () => TopicController(),
    );
  }
}
