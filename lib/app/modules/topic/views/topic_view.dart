import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:quizapp/app/modules/topic/controllers/topic_controller.dart';
import 'package:quizapp/app/routes/app_pages.dart';

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
          (position == 0
              ? Image(image: NetworkImage(img))
              : Text('$heading', style: const TextStyle(fontSize: 20))),
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
              Get.toNamed(Routes.Quiz, arguments: description);
            },
            child: const Text('Generate Quiz'),
          ),
        ]);
      }),
    );
  }
}

class TopicView extends GetView<TopicController> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Get.arguments[1]),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Obx(() => controller.isLoading.value
                ? const Text('Topic Loading')
                : PageView.builder(
                    controller: _pageController,
                    itemCount: controller.topic.value['topics'].length,
                    itemBuilder: (context, position) {
                      return TopicPage(position);
                    })))
        // body: Center(
        //   child: Obx(() {
        //     return controller.isLoading.value
        //         ? const Text('')
        //         : Text(
        //             '${controller.topic.value['page']['title']}',
        //             style: const TextStyle(fontSize: 20),
        //           );
        //   }),
        // ),
        );
  }
}
