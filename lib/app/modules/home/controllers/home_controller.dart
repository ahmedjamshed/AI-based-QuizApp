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

  @override
  void onReady() {
    super.onReady();
    getPosts();
  }

  // Future googleVisionImageProcessing(image) async {
  //   print('googleVisionImageProcessing');
  //   try {
  //     List<int> imageBytes = await image.readAsBytes();
  //     // String imageB64 = base64Encode(imageBytes);

  //     // print("image bytes: $imageBytes");

  //     var x = base64.encode(imageBytes);

  //     var json = returnJSON(x);
  //     print("json: $json");
  //     var url = "https://vision.googleapis.com/v1/images:annotate?key=$key";
  //     var response = await http.post(url, body: json);
  //     print(response.statusCode);
  //     var dic = jsonDecode(response.body);
  //     print("dic: $dic");
  //     var res = dic["responses"];
  //     print("res: $res");
  //     String temp = res[0]["textAnnotations"][0]["description"] as String;
  //     print(temp);
  //     pr.hide();
  //     return temp;
  //   } catch (e) {
  //     pr.hide();
  //     print("errorGoogle $e");
  //     return null;
  //   }
  // }

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile == null) {
      Get.snackbar('Error', 'No Image Selected',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    selectedImagePath.value = pickedFile.path;
  }

  void getPosts() {
    _apiHelper.getPosts().futureValue(
          (dynamic value) => dataList = value,
          retryFunction: getPosts,
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
