import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/topic_controller.dart';

class TopicPage extends GetView<TopicController> {
  const TopicPage(this.position);
  final int position;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Obx(() {
        return Column(children: [
          Text('${controller.topic.value['topics'][position]['heading']}'),
          Text(
            '${controller.topic.value['topics'][position]['description']}',
            style: const TextStyle(fontSize: 20),
          )
        ]);
      }),
    );
  }
}

class TopicView extends GetView<TopicController> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Get.arguments[1]),
          centerTitle: true,
        ),
        body: Obx(() => controller.isLoading.value
            ? const Text('Topic Loading')
            : PageView.builder(
                controller: _pageController,
                itemCount: controller.topic.value['topics'].length,
                itemBuilder: (context, position) {
                  return TopicPage(position);
                }))
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
