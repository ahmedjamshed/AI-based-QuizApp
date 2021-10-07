import 'package:get/get.dart';

export 'package:quizapp/app/common/util/extensions.dart';
export 'package:quizapp/app/common/util/utils.dart';

abstract class ApiHelper {
  Future<Response> getLabels(String base64Image);
}
