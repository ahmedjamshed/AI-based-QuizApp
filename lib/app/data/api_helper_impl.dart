import 'package:get/get.dart';
import 'package:quizapp/app/common/constants.dart';
import 'package:quizapp/app/common/storage/storage.dart';

import 'api_helper.dart';

class ApiHelperImpl extends GetConnect with ApiHelper {
  @override
  void onInit() {
    httpClient.baseUrl = Constants.BASE_URL;
    httpClient.timeout = Constants.timeout;

    addRequestModifier();
    addResponseModifier();
  }

  void addResponseModifier() {
    httpClient.addResponseModifier((request, response) {
      printInfo(
        info: 'Status Code: ${response.statusCode}\n'
            'Data: ${response.bodyString?.toString() ?? ''}',
      );

      return response;
    });
  }

  void addRequestModifier() {
    httpClient.addRequestModifier<dynamic>((request) {
      if (Storage.hasData(Constants.TOKEN)) {
        request.headers['Authorization'] = Storage.getValue(Constants.TOKEN);
      }

      printInfo(
        info: 'REQUEST ║ ${request.method.toUpperCase()}\n'
            'url: ${request.url}\n'
            'Headers: ${request.headers}\n'
            'Body: ${request.files?.toString() ?? ''}\n',
      );

      return request;
    });
  }

  @override
  Future<Response> getLabels(String base64Image) {
    final body = {"data": base64Image};
    return post('predictLabels', body);
  }

  @override
  Future<Response> getTopic(String id) {
    return get('learningMaterial?id=$id');
  }

  @override
  Future<Response> generateQuestions(String material) {
    final body = {"data": material};
    return post('generateQuestions', body);
  }

  @override
  Future<Response> getPreloadedImages() {
    return get('preloadedImages');
  }
}
