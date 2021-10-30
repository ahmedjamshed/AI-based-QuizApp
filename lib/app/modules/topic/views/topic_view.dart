import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/topic_controller.dart';

class TopicView extends GetView<TopicController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TopicView'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() {
          return controller.isLoading.value
              ? const Text('')
              : Text(
                  '${controller.topic.value['page']['title']}',
                  style: const TextStyle(fontSize: 20),
                );
        }),
      ),
    );
  }
}
