import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizapp/app/common/util/exports.dart';
import 'package:quizapp/app/common/util/initializer.dart';
import 'package:quizapp/app/common/values/styles/theme.dart';
import 'package:quizapp/app/routes/app_pages.dart';
// import 'package:flutter/scheduler.dart' show timeDilation;

import 'app/modules/widgets/base_widget.dart';

void main() {
  // timeDilation = 2.0; // slow animation in debug mode
  Initializer.instance.init(() {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      BoxConstraints(
        maxWidth: Get.width,
        maxHeight: Get.height,
      ),
      designSize: Get.size,
    );

    return GetMaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: (_, child) => BaseWidget(
        child: child!,
      ),
    );
  }
}
