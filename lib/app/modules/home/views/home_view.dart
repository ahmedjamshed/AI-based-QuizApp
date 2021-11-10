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
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              delegate: _CustomAppBar(
            minExtended: kToolbarHeight,
            maxExtended: size.height * 0.5,
            size: size,
          )),
          SliverGroupBuilder(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  border: Border.all(color: Color.fromRGBO(238, 237, 238, 1))),
              child: SliverStaggeredGrid.countBuilder(
                crossAxisCount: 2,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) => Container(
                    color: Colors.green,
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text('$index'),
                      ),
                    )),
                staggeredTileBuilder: (int index) =>
                    StaggeredTile.count(1, index.isEven ? 2 : 1),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ))
        ],
      ),
    );
  }
}

// class _CustomBody extends StatelessWidget {
//   const _CustomBody({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

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
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  child: Center(child: Text('trtretet')),
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

class IntSize {
  const IntSize(this.width, this.height);

  final int width;
  final int height;
}

class _Tile extends StatelessWidget {
  const _Tile(this.index, this.size);

  final IntSize size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              //Center(child: CircularProgressIndicator()),
              Center(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: 'https://picsum.photos/${size.width}/${size.height}/',
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: <Widget>[
                Text(
                  'Image number $index',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Width: ${size.width}',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  'Height: ${size.height}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
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
