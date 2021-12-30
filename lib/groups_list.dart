import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:sye/group.dart';
import 'package:sye/group_visualizer.dart';
import 'package:sye/swipeable_item.dart';
import 'db.dart';


class GroupsList extends StatelessWidget {
  const GroupsList({Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FirebaseDatabaseListView(
        query: DB.getGroups(),
        itemBuilder: (context, snapshot) {
          var group = snapshot.value as Map;
          log(group.toString());
          return /*Text(group["name"]);*/
            SwipeableItem(
              item: GroupVisualizer(route: group),
              onDelete: _delete(group["name"]),
          );
        },
        );
  }

  Function _delete(String key) {
    return () => DB.getGroups().child(key).remove();
  }
}