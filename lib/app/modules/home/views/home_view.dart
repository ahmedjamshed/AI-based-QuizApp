import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizapp/app/common/util/exports.dart';
import 'package:quizapp/app/modules/home/controllers/home_controller.dart';
import 'package:quizapp/app/modules/widgets/base_widget.dart';
import 'package:quizapp/app/modules/widgets/custom_appbar_widget.dart';
import 'package:quizapp/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              delegate: _CustomAppBar(
            minExtended: kToolbarHeight,
            maxExtended: size.height * 0.35,
            size: size,
          )),
          const SliverToBoxAdapter(child: _CustomBody())
        ],
      ),
    );
  }
}

class _CustomBody extends StatelessWidget {
  const _CustomBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: MasonryGrid(
              column: 2,
              children: List.generate(
                30,
                (i) => const SizedBox(
                    width: 100, height: 100, child: Text("hello")),
              )),
        ));
  }
}

class _CustomAppBar extends SliverPersistentHeaderDelegate {
  const _CustomAppBar(
      {required this.maxExtended,
      required this.minExtended,
      required this.size});
  final double maxExtended;
  final double minExtended;
  final Size size;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        child: Stack(
      children: [
        Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ))
      ],
    ));
  }

  @override
  double get maxExtent => maxExtended;

  @override
  double get minExtent => minExtended;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

// class HomeView extends GetView<HomeController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: CustomAppbarWidget(
//           addBackButton: false,
//           title: Strings.home,
//         ),
//         body: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       controller.getImage(ImageSource.camera);
//                     },
//                     icon: const Icon(Icons.camera)),
//                 IconButton(
//                     onPressed: () {
//                       controller.getImage(ImageSource.gallery);
//                     },
//                     icon: const Icon(Icons.image)),
//               ],
//             ),
//             Obx(() => controller.selectedImagePath.value != ''
//                 ? Image.file(File(controller.selectedImagePath.value))
//                 : const Text('Select the Image')),
//             Expanded(
//               child: Obx(
//                 () {
//                   return ListView.separated(
//                     separatorBuilder: (context, index) =>
//                         SizedBox(height: 10.h),
//                     itemCount: controller.dataList.length,
//                     padding: const EdgeInsets.all(16),
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       final dynamic _data = controller.dataList[index];

//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 _data['description'].toString(),
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               SizedBox(height: 5.h),
//                               Text(
//                                 'Score: ${_data['score'].toString()}',
//                               ),
//                               SizedBox(height: 5.h),
//                               Text(
//                                 'Relevance: ${_data['topicality'].toString()}',
//                               ),
//                             ],
//                           ),
//                           ElevatedButton(
//                             style:
//                                 ElevatedButton.styleFrom(primary: Colors.black),
//                             onPressed: () {
//                               Get.toNamed(Routes.TOPIC, arguments: [
//                                 _data['mid'],
//                                 _data['description']
//                               ]);
//                             },
//                             child: const Text('Go'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//               ),
//             )
//           ],
//         ));
//   }
// }
