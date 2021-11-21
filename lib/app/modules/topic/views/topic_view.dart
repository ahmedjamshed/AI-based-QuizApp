import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/app/modules/labels/controllers/labels_controller.dart';
import 'package:quizapp/app/modules/topic/controllers/topic_controller.dart';
import 'package:quizapp/app/modules/topic/views/content_view.dart';
import 'package:quizapp/app/modules/topic/views/drawer_view.dart';

const xOffset = 230.0;
const yOffset = 150.0;
const scaleFactor = 0.6;

class TopicView extends GetView<TopicController> {
  const TopicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Label _data = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(_data.name),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const DrawerView(),
          Obx(() {
            final isOpen = controller.isDrawerOpen.value;
            return AnimatedContainer(
                transform: Matrix4.translationValues(
                    isOpen ? xOffset : 80, isOpen ? yOffset : 0, 0)
                  ..scale(isOpen ? scaleFactor : 1.0)
                  ..rotateY(isOpen ? -0.5 : 0),
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(isOpen ? 40 : 0.0)),
                child: InkWell(
                    onTap: () => isOpen ? controller.toggleDrawer() : null,
                    child: ContentView()));
          })
        ],
      ),
    );
  }
}
