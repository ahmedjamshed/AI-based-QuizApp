import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizapp/app/controllers/appController.dart';
import 'package:quizapp/app/data/api_helper.dart';
import 'package:quizapp/app/data/api_helper_impl.dart';
import 'package:quizapp/app/data/interface_controller/api_interface_controller.dart';
import 'package:quizapp/app/modules/widgets/custom_error_widget.dart';

class Initializer {
  static final Initializer instance = Initializer._internal();
  factory Initializer() => instance;
  Initializer._internal();

  void init(VoidCallback runApp) {
    ErrorWidget.builder = (errorDetails) {
      return CustomErrorWidget(
        message: errorDetails.exceptionAsString(),
      );
    };

    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = (details) {
        FlutterError.dumpErrorToConsole(details);
        printInfo(info: details.stack.toString());
      };

      await _initServices();
      runApp();
    }, (error, stack) {
      printInfo(info: 'runZonedGuarded: ${stack.toString()}');
    });
  }

  Future<void> _initServices() async {
    try {
      await _initStorage();

      _initScreenPreference();
      _initApis();
      _initStore();
    } catch (err) {
      rethrow;
    }
  }

  void _initStore() {
    Get.put<AppController>(
      AppController(),
    );
  }

  void _initApis() {
    Get.put<ApiHelper>(
      ApiHelperImpl(),
    );

    Get.put<ApiInterfaceController>(
      ApiInterfaceController(),
    );
  }

  Future<void> _initStorage() async {
    await GetStorage.init();
  }

  void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
