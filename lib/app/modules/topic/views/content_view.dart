import 'dart:ui';

import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
          offset: Offset(0.0, 0.0),
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
      final double scaleFactor =
          1.0; //MIN_SCALE + (1 - MIN_SCALE) * (1 - position);

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

class TopicPage extends GetView<TopicController> {
  const TopicPage(this.position);
  final int position;
  @override
  Widget build(BuildContext context) {
    final heading = controller.dataList[position].heading;
    final description = controller.dataList[position].description;

    return Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(children: [
          // ignore: prefer_if_elements_to_conditional_expressions
          Text(heading, style: Theme.of(context).textTheme.headline6),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                description,
                style: Theme.of(context).textTheme.bodyText1,
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
        ]));
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
