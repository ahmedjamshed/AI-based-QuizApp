import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/app/data/api_helper.dart';
import 'package:quizapp/app/modules/labels/controllers/labels_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Topic {
  final String heading;
  final String description;
  final List<Topic> subTopics;

  Topic(this.heading, this.description, this.subTopics);
  factory Topic.fromMap(dynamic json) {
    final List<Topic> subTopics = [];
    for (final subTopic in json['subTopics']) {
      subTopics.add(Topic(subTopic['heading'], subTopic['description'], []));
    }
    return Topic(json['heading'], json['description'], subTopics);
  }
}

class TopicController extends GetxController {
  final ApiHelper _apiHelper = Get.find();

  final List<Topic> _dataList = [Topic('Intro', '', [])];
  List<Topic> get dataList => _dataList;
  set dataList(List<Topic> dataList) => _dataList.addAll(dataList);

  final RxBool _isLoading = true.obs;
  dynamic get isLoading => _isLoading;

  final RxInt currentPage = 0.obs;

  final pageController = IndexController();
  final itemScrollController = AutoScrollController();

  final RxBool isDrawerOpen = false.obs;

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  void getTopic(String title) {
    _isLoading.value = true;
    _apiHelper.getTopic(title).futureValue((dynamic value) {
      dataList =
          value['topics'].map<Topic>((val) => Topic.fromMap(val)).toList();
      _isLoading.value = false;
    });
  }

  void gotoPage(int position, {bool fromDrawer = false}) {
    currentPage.value = position;
    fromDrawer
        ? pageController.move(position)
        : itemScrollController.scrollToIndex(position);
  }

  @override
  void onInit() {
    // pageController.addListener(() {
    //   currentPage.value = pageController.index ?? 0;
    //   print('ahmed' + pageController.index.toString());
    // });
    super.onInit();
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
