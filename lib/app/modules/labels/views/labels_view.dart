import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:quizapp/app/modules/labels/controllers/labels_controller.dart';

class LabelsView extends GetView<LabelsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        centerTitle: true,
      ),
      body: SafeArea(child: Obx(
        () {
          return controller.isLoading.value
              ? const Text('Loading')
              : ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemCount: controller.dataList.length,
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final dynamic _data = controller.dataList[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_data['question']),
                        Text(_data['answer']),
                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black),
                          onPressed: () {},
                          child: const Text('Go'),
                        ),
                      ],
                    );
                  },
                );
        },
      )),
    );
  }
}
