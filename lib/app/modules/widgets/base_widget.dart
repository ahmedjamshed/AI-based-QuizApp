import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/app/data/interface_controller/api_interface_controller.dart';
import 'package:quizapp/app/modules/widgets/custom_retry_widget.dart';

export 'package:quizapp/app/common/util/exports.dart';

class BaseWidget extends GetView<ApiInterfaceController> {
  ///A widget with only custom retry button widget.
  final Widget child;

  const BaseWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Positioned.fill(
            child: child,
          ),
          Visibility(
            visible: controller.retry != null && controller.error != null,
            child: Positioned.fill(
              child: Scaffold(
                body: CustomRetryWidget(
                  onPressed: () {
                    controller.error = null;
                    controller.retry?.call();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
