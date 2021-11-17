import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_group_sliver/flutter_group_sliver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizapp/app/common/util/exports.dart';
import 'package:quizapp/app/modules/home/controllers/home_controller.dart';
import 'package:quizapp/app/modules/widgets/base_widget.dart';
import 'package:quizapp/app/modules/widgets/custom_appbar_widget.dart';
import 'package:quizapp/app/routes/app_pages.dart';

const double radius = 30;

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              // pinned: true,
              delegate: _CustomAppBar(
            minExtended: kToolbarHeight,
            maxExtended: size.height * 0.5,
            size: size,
          )),
          SliverGroupBuilder(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              child: Obx(() => SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 2,
                        itemCount: controller.imagesList.length,
                        itemBuilder: (BuildContext context, int index) =>
                            _ImageBuilder(index: index),
                        staggeredTileBuilder: (int index) =>
                            const StaggeredTile.fit(1),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      )
                  // : const SliverToBoxAdapter(
                  //     child: Center(
                  //       child: Text('Loading'),
                  //     ),
                  //   )
                  ))
        ],
      ),
    );
  }
}

class _ImageBuilder extends GetView<HomeController> {
  const _ImageBuilder({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Obx(() {
        return InkWell(
          onTap: () {
            controller.selectedUrl(index);
            Get.toNamed(Routes.LABELS);
            // controller.getLabels(controller.imagesList[index]);
          },
          child: ClipRRect(
            borderRadius: 15.borderRadius,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: controller.imagesList[index],
              fit: BoxFit.cover,
            ),
          ),
        );
      }),
    );
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
    final top = maxExtended - shrinkOffset - 30 / 2;
    return Container(
        color: Theme.of(context).primaryColor,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            buildBackground(shrinkOffset),
            buildAppBar(shrinkOffset),
            Positioned(
              top: top,
              left: 20,
              right: 20,
              child: buildFloating(shrinkOffset),
            ),
          ],
        ));
  }

  double appear(double shrinkOffset) => shrinkOffset / maxExtended;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / maxExtended;

  // Widget buildBackground(double shrinkOffset) => Opacity(
  //       opacity: disappear(shrinkOffset),
  //       child: Image.network(
  //         'https://source.unsplash.com/random?mono+dark',
  //         fit: BoxFit.cover,
  //       ),
  //     );

  Widget buildBackground(double shrinkOffset) => Container(
      margin: EdgeInsets.only(bottom: 50),
      decoration: const BoxDecoration(
        color: Colors.amber,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
      ));

  Widget buildAppBar(double shrinkOffset) => Opacity(
        opacity: appear(shrinkOffset),
        child: AppBar(
          title: Text('Select Image'),
          centerTitle: true,
        ),
      );
  Widget buildFloating(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Card(
          child: Row(
            children: const [
              Expanded(child: Text("left")),
              Expanded(child: Text("Right")),
            ],
          ),
        ),
      );

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
