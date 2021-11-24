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
                  highlightColor: Colors.black,
                  child: TimelineTile(
                    key: ValueKey(position),
                    alignment: TimelineAlign.end,
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
                        child: Obx(
                          () => Center(
                              child: Text(position.toString(),
                                  style: TextStyle(
                                      color: controller.currentPage.value ==
                                              position
                                          ? Colors.amber
                                          : Colors.white,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ),
                    ),
                    startChild: InkWell(
                      onTap: () {
                        controller.gotoPage(position, true);
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: const BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: RotatedBox(
                            quarterTurns: -1,
                            child: Text(_data.heading,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1),
                          )),
                    ),
                  ),
                );
              });
    });
  }
}
