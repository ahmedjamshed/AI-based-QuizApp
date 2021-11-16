import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:quizapp/app/modules/labels/controllers/labels_controller.dart';
import 'package:quizapp/app/routes/app_pages.dart';
import 'package:transparent_image/transparent_image.dart';

class LabelPage extends GetView<LabelsController> {
  const LabelPage(this.position);
  final int position;
  static const imageHeight = 250.0;
  @override
  Widget build(BuildContext context) {
    final _data = controller.dataList[position];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(Routes.TOPIC, arguments: _data);
          },
          child: Stack(alignment: Alignment.topCenter, children: [
            Padding(
              padding: const EdgeInsets.only(top: imageHeight / 2),
              child: Card(
                color: Colors.green,
                child: Container(
                  margin: EdgeInsets.only(top: imageHeight / 2),
                  child: Column(
                    children: [
                      Text(_data.name, style: const TextStyle(fontSize: 20)),
                      Text(_data.description,
                          style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ),
            ),
            Hero(
                tag: _data.name,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: CachedNetworkImage(
                      height: imageHeight,
                      fit: BoxFit.fitHeight,
                      imageUrl: _data.image,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ))),
          ]),
        )
      ],
    );
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
      body: SafeArea(child: Container(
        child: Obx(
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
        ),
      )),
    );
  }
}
