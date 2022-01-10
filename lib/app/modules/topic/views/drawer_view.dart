import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/app/common/util/exports.dart';
import 'package:quizapp/app/modules/topic/controllers/topic_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
// import 'package:timeline_tile/timeline_tile.dart';

class DrawerView extends GetView<TopicController> {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: controller.itemScrollController,
              itemCount: controller.dataList.length,
              itemBuilder: (context, position) {
                final _data = controller.dataList[position];
                return AutoScrollTag(
                  key: ValueKey(position),
                  controller: controller.itemScrollController,
                  index: position,
                  child: Obx(() {
                    final isSelected = controller.currentPage.value == position;
                    final style = isSelected
                        ? const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22)
                        : const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20);
                    // final width = MediaQuery.of(context).size.width;
                    final double p = isSelected ? 5 : 0;
                    return InkWell(
                      onTap: () {
                        controller.gotoPage(position, fromDrawer: true);
                      },
                      child: AnimatedContainer(
                          duration: const Duration(microseconds: 500),
                          margin: EdgeInsets.fromLTRB(5 - p, 5, 5 - p, 5),
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black87.withOpacity(0.3),
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                  offset: const Offset(1, 0))
                            ],
                            color: Theme.of(context).primaryColor,
                            // borderRadius: const BorderRadius.only(
                            //     topRight: Radius.circular(15),
                            //     bottomRight: Radius.circular(15)),
                          ),
                          child: Center(
                            child: RotatedBox(
                                quarterTurns: -1,
                                child: Text(_data.heading.limit(30),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: style)),
                          )),
                    );
                  }),
                );
              });
    });
  }
}
