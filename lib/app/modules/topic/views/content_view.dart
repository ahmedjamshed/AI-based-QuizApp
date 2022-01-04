import 'dart:convert';
import 'dart:ui';

import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:quizapp/app/modules/labels/controllers/labels_controller.dart';

import 'package:quizapp/app/modules/topic/controllers/topic_controller.dart';
import 'package:quizapp/app/routes/app_pages.dart';

class DeepthPageTransformer extends PageTransformer {
  DeepthPageTransformer() : super(reverse: true);

  @override
  Widget transform(Widget child, TransformInfo info) {
    final double position = info.position ?? 0.0;
    // print(position);
    if (position <= 0) {
      return Opacity(
        opacity: 1.0,
        child: Transform.translate(
          offset: const Offset(0.0, 0.0),
          child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(-position),
              child: child),
        ),
        // child: Transform.translate(
        //   offset: Offset(0.0, 0.0),
        //   child: Transform.scale(
        //     scale: 1.0,
        //     child: child,
        //   ),
        // ),
      );
    } else if (position <= 1) {
      const double MIN_SCALE = 0.75;
      // Scale the page down (between MIN_SCALE and 1)
      const double scaleFactor = 1.0;
      // MIN_SCALE + (1 - MIN_SCALE) * (1 - position);

      return Opacity(
        opacity: 1.0 - position,
        child: Transform.translate(
          offset: Offset(
              -position * (info.width ?? 0.0), 0.0), // info.width * -position
          child: Transform.scale(
            scale: scaleFactor,
            child: child,
          ),
        ),
      );
    }

    return child;
  }
}

class SubTopic extends StatelessWidget {
  const SubTopic(this.subTopic, {required this.pos, required this.isMain});
  final Topic subTopic;
  final int pos;
  final bool isMain;
  @override
  Widget build(BuildContext context) {
    final heading = this.subTopic.heading;
    final description = this.subTopic.description;

    return Column(
      children: [
        if (this.isMain)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Chapter: ${this.pos}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                  onPressed: () {
                    Get.toNamed(Routes.QUIZ,
                        arguments: jsonEncode(this.subTopic));
                  },
                  icon: Icon(Icons.quiz, color: Theme.of(context).primaryColor),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      elevation: 0),
                  label: Text("Generate Quiz",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))),
            ],
          )
        else
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
            child: Text(heading,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
          ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Text(description,
              style: const TextStyle(color: Colors.black, fontSize: 18)),
        ),
      ],
    );
  }
}

class TopicPage extends GetView<TopicController> {
  const TopicPage(this.position);
  final int position;
  @override
  Widget build(BuildContext context) {
    final topic = controller.dataList[position];
    final subTopics = topic.subTopics;
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 5, 5, 5),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: ListView.builder(
            itemCount: subTopics.length + 1,
            itemBuilder: (context, pos) {
              return pos == 0
                  ? SubTopic(
                      topic,
                      pos: position,
                      isMain: true,
                    )
                  : SubTopic(
                      subTopics[pos - 1],
                      pos: position,
                      isMain: false,
                    );
            }));
  }
}

class CoverPage extends GetView<TopicController> {
  const CoverPage();
  @override
  Widget build(BuildContext context) {
    final Label _data = Get.arguments ?? Label('', '', [], '');
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

class ContentView extends GetView<TopicController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Obx(() => controller.isLoading.value
                ? const CoverPage()
                : TransformerPageView(
                    // allowImplicitScrolling: true,
                    controller: controller.pageController,
                    onPageChanged: (index) {
                      controller.gotoPage(index ?? 0);
                    },
                    curve: Curves.easeInBack,
                    transformer: DeepthPageTransformer(),
                    itemCount: controller.dataList.length,
                    itemBuilder: (context, position) {
                      return position == 0
                          ? const CoverPage()
                          : TopicPage(position);
                    }))));
  }
}
