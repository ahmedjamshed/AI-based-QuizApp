import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:quizapp/app/modules/quiz/controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return controller.isLoading.value ? Text('Loading') : Text('Loaded');
          // : ListView.separated(
          //     separatorBuilder: (context, index) =>
          //         SizedBox(height: 10.h),
          //     itemCount: controller.quizList.length,
          //     padding: const EdgeInsets.all(16),
          //     shrinkWrap: true,
          //     itemBuilder: (context, index) {
          //       final dynamic _data = controller.quizList[index];
          //       return Text('hello');
          //       // return Row(
          //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       //   children: [
          //       //     Text(_data['question']),
          //       //     ElevatedButton(
          //       //       style: ElevatedButton.styleFrom(primary: Colors.black),
          //       //       onPressed: () {},
          //       //       child: const Text('Go'),
          //       //     ),
          //       //   ],
          //       // );
          //     },
          //   );
        },
      ),
    );
  }
}
