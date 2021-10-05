import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizapp/app/common/util/exports.dart';
import 'package:quizapp/app/modules/home/controllers/home_controller.dart';
import 'package:quizapp/app/modules/widgets/base_widget.dart';
import 'package:quizapp/app/modules/widgets/custom_appbar_widget.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarWidget(
          addBackButton: false,
          title: Strings.home,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      controller.getImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera)),
                IconButton(
                    onPressed: () {
                      controller.getImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image)),
              ],
            ),
            Obx(() => controller.selectedImagePath.value != ''
                ? Image.file(File(controller.selectedImagePath.value))
                : const Text('Select the Image')),
            Expanded(
              child: Obx(
                () {
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.h),
                    itemCount: controller.dataList.length,
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final dynamic _data = controller.dataList[index];

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title: ${_data['title'].toString()}',
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'Body: ${_data['body'].toString()}',
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ));
  }
}
