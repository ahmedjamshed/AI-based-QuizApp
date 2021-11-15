import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quizapp/app/modules/labels/controllers/labels_controller.dart';

import 'package:quizapp/app/modules/topic/controllers/topic_controller.dart';
import 'package:quizapp/app/routes/app_pages.dart';
import 'package:transparent_image/transparent_image.dart';

class TopicPage extends GetView<TopicController> {
  const TopicPage(this.position);
  final int position;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Obx(() {
        final img = controller.topic.value['page']['original']['source'];
        final description =
            controller.topic.value['topics'][position]['description'];
        final heading = controller.topic.value['topics'][position]['heading'];
        return Column(children: [
          // ignore: prefer_if_elements_to_conditional_expressions
          Text('$heading', style: const TextStyle(fontSize: 20)),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                '$description',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.black, padding: const EdgeInsets.all(8)),
            onPressed: () {
              Get.toNamed(Routes.QUIZ, arguments: description);
            },
            child: const Text('Generate Quiz'),
          ),
        ]);
      }),
    );
  }
}

class CoverPage extends GetView<TopicController> {
  const CoverPage();
  @override
  Widget build(BuildContext context) {
    final Label _data = Get.arguments;
    return Container(
        margin: const EdgeInsets.all(15),
        child: Column(children: [
          // ignore: prefer_if_elements_to_conditional_expressions
          Hero(
              tag: _data.name,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Image(
                  image: CachedNetworkImageProvider(_data.image),
                  fit: BoxFit.cover,
                ),
              )),
          Text(_data.name, style: const TextStyle(fontSize: 20)),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                _data.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ]));
  }
}

class TopicView extends GetView<TopicController> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final Label _data = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(_data.name),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Obx(() => PageView.builder(
                // allowImplicitScrolling: true,
                controller: _pageController,
                itemCount: (controller.topic.value['topics']?.length ?? 0) + 1,
                itemBuilder: (context, position) {
                  return position == 0
                      ? const CoverPage()
                      : TopicPage(position - 1);
                }))));
  }
}
