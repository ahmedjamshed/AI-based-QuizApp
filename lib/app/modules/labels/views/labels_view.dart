import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:quizapp/app/modules/labels/controllers/labels_controller.dart';
import 'package:quizapp/app/routes/app_pages.dart';

class LabelPage extends GetView<LabelsController> {
  const LabelPage(this.position);
  final int position;
  @override
  Widget build(BuildContext context) {
    final _data = controller.dataList[position];

    return Container(
        margin: const EdgeInsets.all(15),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Hero(tag: _data.name, child: Image(image: NetworkImage(_data.image))),
          Text(_data.name, style: const TextStyle(fontSize: 20)),
          Text(_data.description, style: const TextStyle(fontSize: 20)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.black, padding: const EdgeInsets.all(8)),
            onPressed: () {
              Get.toNamed(Routes.TOPIC, arguments: _data);
            },
            child: const Text('TOPIC'),
          ),
        ]));
  }
}

class LabelsView extends GetView<LabelsController> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Labels'),
        centerTitle: true,
      ),
      body: SafeArea(child: Obx(
        () {
          return controller.isLoading.value
              ? const Text('Loading')
              : PageView.builder(
                  controller: _pageController,
                  itemCount: controller.dataList.length,
                  itemBuilder: (context, position) {
                    return LabelPage(position);
                  });
        },
      )),
    );
  }
}
