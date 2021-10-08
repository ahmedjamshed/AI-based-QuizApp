import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizapp/app/common/storage/storage.dart';
import 'package:quizapp/app/data/api_helper.dart';

class HomeController extends GetxController {
  final ApiHelper _apiHelper = Get.find();

  final RxList _dataList = RxList();
  List<dynamic> get dataList => _dataList;
  set dataList(List<dynamic> dataList) => _dataList.addAll(dataList);

  RxString selectedImagePath = ''.obs;

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(
        source: imageSource, maxWidth: 500, maxHeight: 300, imageQuality: 80);
    if (pickedFile == null) {
      Get.snackbar('Error', 'No Image Selected',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final bytes = await pickedFile.readAsBytes();
    getLabels(base64Encode(bytes));
    selectedImagePath.value = pickedFile.path;
  }

  void getLabels(String base64Img) {
    _dataList.clear();
    _apiHelper.getLabels(base64Img).futureValue(
          (dynamic value) => dataList = value,
        );
  }

  void onEditProfileClick() {
    Get.back();
  }

  void onFaqsClick() {
    Get.back();
  }

  void onLogoutClick() {
    Storage.clearStorage();
    // Get.offAllNamed(Routes.HOME);
    //Specify the INITIAL SCREEN you want to display to the user after logout
  }
}
