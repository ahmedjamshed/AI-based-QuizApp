import 'package:get/get.dart';
import 'package:quizapp/app/modules/labels/controllers/labels_controller.dart';

class LabelsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LabelsController>(
      () => LabelsController(),
    );
  }
}
