import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quizapp/app/common/util/extensions.dart';
import 'package:quizapp/app/modules/labels/controllers/labels_controller.dart';
import 'package:quizapp/app/routes/app_pages.dart';
import 'package:transparent_image/transparent_image.dart';

class LabelPage extends GetView<LabelsController> {
  const LabelPage(this.position);
  final int position;
  static const imageHeight = 200.0;
  @override
  Widget build(BuildContext context) {
    final _data = controller.dataList[position];

    return Container(
      margin: EdgeInsets.all(15),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.TOPIC, arguments: _data);
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: CachedNetworkImage(imageUrl: _data.image),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Hero(
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
            ),
          ],
        ),
      ),
    );
  }
}

class LabelsView extends GetView<LabelsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Labels'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Obx(
          () {
            final _data = controller.isLoading.value
                ? Label('', '', [], '')
                : controller.dataList[controller.currentPage.value];
            return controller.isLoading.value
                ? const Text('Loading')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: animatedScale(Text(
                        _data.name,
                        key: ValueKey<String>(_data.name),
                        style:
                            const TextStyle(fontSize: 40, color: Colors.black),
                      ))),
                      Expanded(
                        flex: 2,
                        child: PageView.builder(
                            controller: controller.pageController,
                            itemCount: controller.dataList.length,
                            itemBuilder: (context, position) {
                              // Future.delayed(Duration.zero, () async {
                              //   currentPosition.value = position;
                              // });
                              return LabelPage(position);
                            }),
                      ),
                      Expanded(
                          child: animatedSlide(Container(
                        height: double.infinity,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10),
                        key: ValueKey<String>(_data.description),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(25)),
                            color: Theme.of(context).primaryColor),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            _data.description,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ))),
                    ],
                  );
          },
        ),
      )),
    );
  }

  Widget animatedScale(Widget child) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
            child: child,
          );
        },
        child: child,
      );

  Widget animatedSlide(Widget child) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransition(
            position: Tween<Offset>(
                    begin: const Offset(0.0, 2), end: const Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        },
        child: child,
      );
}
