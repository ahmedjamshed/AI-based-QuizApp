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
  static num border = 25;
  @override
  Widget build(BuildContext context) {
    final _data = controller.dataList[position];
    final margin = controller.currentPage.value == position ? 0.0 : 50.0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.only(top: margin, bottom: margin, right: 15, left: 15),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.TOPIC, arguments: _data);
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: border.borderRadius,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: CachedNetworkImage(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill,
                    imageUrl: _data.image),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: border.borderRadius,
                color: Colors.black.withOpacity(0.2),
              ),
              clipBehavior: Clip.hardEdge,
              child: Hero(
                  tag: _data.name,
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width * 0.8,
                    fit: BoxFit.contain,
                    imageUrl: _data.image,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )),
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
                ? Center(
                    child: Text(
                    controller.isLoading,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22.0),
                  ))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: animatedScale(Text(
                        _data.name,
                        key: ValueKey<String>(_data.name),
                        style: const TextStyle(
                            fontSize: 32,
                            color: Colors.pink,
                            fontWeight: FontWeight.bold),
                      ))),
                      Expanded(
                        flex: 2,
                        child: PageView.builder(
                            controller: controller.pageController,
                            itemCount: controller.dataList.length,
                            itemBuilder: (context, position) {
                              return LabelPage(position);
                            }),
                      ),
                      Expanded(
                          child: animatedSlide(BottomDesc(
                              key: ValueKey<String>(_data.description),
                              data: _data))),
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
              curve: Curves.elasticInOut,
            ),
            child: child,
          );
        },
        child: child,
      );

  Widget animatedSlide(Widget child) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
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

class BottomDesc extends StatelessWidget {
  const BottomDesc({
    Key? key,
    required Label data,
  })  : _data = data,
        super(key: key);

  final Label _data;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black87.withOpacity(0.3),
                  blurRadius: 3,
                  offset: const Offset(0, -2.5))
            ],
            // borderRadius: const BorderRadius.vertical(
            //     top: Radius.circular(40)),
            color: Theme.of(context).primaryColor),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Text(
            _data.description,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
