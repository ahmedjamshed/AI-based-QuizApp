import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/app/modules/labels/controllers/labels_controller.dart';
import 'package:quizapp/app/modules/topic/controllers/topic_controller.dart';
import 'package:quizapp/app/modules/topic/views/content_view.dart';
import 'package:quizapp/app/modules/topic/views/drawer_view.dart';

const xOffset = 230.0;
const yOffset = 150.0;
const scaleFactor = 0.6;

const _duration = Duration(milliseconds: 250);

class TopicView extends GetView<TopicController> {
  const TopicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Label _data = Get.arguments ?? Label('', '', [], '');
    return Scaffold(
        appBar: AppBar(
          title: Text(_data.name),
          centerTitle: true,
          actions: [
            // IconButton(
            //     onPressed: () {},
            //     color: Colors.white,
            //     icon: const Icon(
            //       Icons.quiz,
            //       size: 30,
            //     ))
          ],
        ),
        body: SafeArea(
          child: Row(
            children: [
              const Flexible(child: DrawerView()),
              Flexible(flex: 9, child: ContentView())
            ],
          ),
        ));
  }
}
