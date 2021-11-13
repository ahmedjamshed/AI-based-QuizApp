import 'package:get/get.dart';
import 'package:quizapp/app/controllers/appController.dart';
import 'package:quizapp/app/data/api_helper.dart';

class Label {
  final String name;
  final String description;
  final int alias;
  final String image;

  Label(this.name, this.description, this.alias, this.image);
  factory Label.fromMap(Map<String, dynamic> json) {
    return Label(
      json['name'],
      json['description'],
      json['price'],
      json['image'],
    );
  }
}

class LabelsController extends GetxController {
  final ApiHelper _apiHelper = Get.find();
  final AppController _appController = Get.find();

  final List _dataList = [];
  List<dynamic> get dataList => _dataList;
  set dataList(List<dynamic> dataList) => _dataList.addAll(dataList);

  final RxBool _isLoading = true.obs;
  dynamic get isLoading => _isLoading;

  void getLabels(String img) {
    _dataList.clear();
    _apiHelper.getLabels(img).futureValue(
          (dynamic value) => dataList = value,
        );
  }

  @override
  void onReady() {
    super.onReady();
    final content = _appController.selectedImage;
    getLabels(content);
  }
}
