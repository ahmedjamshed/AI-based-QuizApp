import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizapp/app/common/storage/storage.dart';
import 'package:quizapp/app/controllers/appController.dart';
import 'package:quizapp/app/data/api_helper.dart';

class HomeController extends GetxController {
  final ApiHelper _apiHelper = Get.find();
  final AppController _appController = Get.find();

  final RxList _imagesList = RxList();
  List<dynamic> get imagesList => _imagesList;
  set imagesList(List<dynamic> imagesList) => _imagesList.addAll(imagesList);

  RxString selectedImagePath = ''.obs;

  final RxBool _isLoading = true.obs;
  dynamic get isLoading => _isLoading;

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(
        source: imageSource, maxWidth: 500, maxHeight: 300, imageQuality: 80);
    if (pickedFile == null) {
      Get.snackbar('Error', 'No Image Selected',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final bytes = await pickedFile.readAsBytes();
    _appController.selectedImage = base64Encode(bytes);
    // getLabels();
    selectedImagePath.value = pickedFile.path;
  }

  // Future LoadImages(dynamic images) async {
  //   images.map((url) => precacheImage(url));
  //   imagesList =
  // }

  void getPreloadedImages() {
    _imagesList.clear();
    _apiHelper.getPreloadedImages().futureValue(
          (dynamic value) => imagesList = value,
        );
  }

  void selectedUrl(int index) {
    _appController.selectedImage = imagesList[index];
  }

  @override
  void onReady() {
    getPreloadedImages();
    super.onReady();
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
