import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
            child: CachedNetworkImage(
              placeholder: (context, url) => const Icon(
                Icons.image,
                color: Colors.white,
                size: 42,
              ),
              fit: BoxFit.cover,
              imageUrl: controller.imagesList[index],
            ),
          ),
        );
      }),
    );
  }
}

// FadeInImage.memoryNetwork(
//               placeholder: kTransparentImage,
//               image: controller.imagesList[index],
//               fit: BoxFit.cover,
//             )

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
    final iconSize = (maxExtended - shrinkOffset) / 2;

    return Container(
        color: Theme.of(context).primaryColor,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            HeaderWidget(iconSize: iconSize)
            // buildBackground(shrinkOffset),
            // buildAppBar(shrinkOffset),
            // Positioned(
            //   top: top,
            //   left: 20,
            //   right: 20,
            //   child: buildFloating(shrinkOffset),
            // ),
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

  Widget buildBackground(double iconSize) => Container(
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

class HeaderWidget extends GetView<HomeController> {
  const HeaderWidget({
    Key? key,
    required this.iconSize,
  }) : super(key: key);

  final double iconSize;

  @override
  Widget build(BuildContext context) => Opacity(
      opacity: 1, //appear(shrinkOffset),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Obx(
            () => controller.selectedImagePath.value != ''
                ? Image.file(File(controller.selectedImagePath.value))
                : IconButton(
                    onPressed: () {
                      controller.getImage(ImageSource.gallery);
                    },
                    color: Colors.white,
                    icon: Icon(
                      Icons.add_photo_alternate_rounded,
                      size: iconSize,
                    )),
          )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.LABELS);
                  },
                  color: Colors.white,
                  icon: Icon(Icons.travel_explore_sharp,
                      size: iconSize > 50 ? 60 : 0))
            ],
          ))
        ],
      ));
}
