import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:quizapp/app/modules/topic/controllers/topic_controller.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DrawerView extends GetView<TopicController> {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, position) {
          return TimelineTile(
            endChild: Container(
              color: Colors.lightGreenAccent,
              child: Text(
                position.toString(),
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          );
        });
  }
}
