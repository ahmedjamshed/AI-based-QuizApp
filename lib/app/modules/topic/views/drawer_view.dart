import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:quizapp/app/modules/topic/controllers/topic_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DrawerView extends GetView<TopicController> {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value
          ? const Text('Loading')
          : ListView.builder(
              controller: controller.itemScrollController,
              itemCount: controller.dataList.length,
              itemBuilder: (context, position) {
                final _data = controller.dataList[position];
                return AutoScrollTag(
                  key: ValueKey(position),
                  controller: controller.itemScrollController,
                  index: position,
                  child: TimelineTile(
                    key: ValueKey(position),
                    alignment: TimelineAlign.center,
                    isFirst: position == 0,
                    isLast: position == controller.dataList.length - 1,
                    beforeLineStyle: const LineStyle(color: Colors.white),
                    indicatorStyle: IndicatorStyle(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      drawGap: true,
                      indicator: Container(
                        decoration: const BoxDecoration(
                          border: Border.fromBorderSide(
                            BorderSide(color: Colors.white, width: 4.0),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                            child: Text(position.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ),
                    startChild: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: Colors.teal,
                      height: 180,
                      width: 2,
                      // child: Text(_data.heading,
                      //     style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                );
              });
    });
  }
}
