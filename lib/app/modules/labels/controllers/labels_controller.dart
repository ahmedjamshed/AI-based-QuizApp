import 'dart:convert';

import 'package:get/get.dart';
import 'package:quizapp/app/controllers/appController.dart';
import 'package:quizapp/app/data/api_helper.dart';

class Label {
  final String name;
  final String description;
  // final List<String> alias;
  final String image;

  Label(this.name, this.description, this.image);
  factory Label.fromMap(dynamic json) {
    return Label(
      json['title'].toString(),
      json['terms']['description'][0].toString(),
      // json['terms']['alias'],
      json['original']['source'].toString(),
    );
  }
}

class LabelsController extends GetxController {
  final ApiHelper _apiHelper = Get.find();
  final AppController _appController = Get.find();

  final List<Label> _dataList = [];
  List<Label> get dataList => _dataList;
  set dataList(List<Label> dataList) => _dataList.addAll(dataList);

  final RxBool _isLoading = true.obs;
  dynamic get isLoading => _isLoading;

  void getLabels(String img) {
    _dataList.clear();
    _apiHelper.getLabels(img).futureValue((dynamic value) {
      dataList = value.map<Label>((val) => Label.fromMap(val)).toList();
      _isLoading.value = false;
    });
  }

  @override
  void onReady() {
    super.onReady();
    final content = _appController.selectedImage;
    getLabels(content);
  }
}
