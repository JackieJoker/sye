import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:sye/swipeable_item.dart';
import 'db.dart';
import 'group.dart';

class GroupsList extends StatelessWidget {
  final String _userId;
  const GroupsList({required String userId, Key? key})
      : _userId = userId,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return FirebaseDatabaseListView(
        query: DB.getGroups(),
        itemBuilder: (context, snapshot) {
          var group = snapshot.value as Map;
          return SwipeableItem(
            item: Group(
              name: group["name"],
              description: group["description"],
              currency: group["currency"],
              category: group["category"],
            ),
            onDelete: _delete(snapshot.key!),
          );

        },
        );
  }
  Function _delete(String key) {
    return () => DB.getGroups().child(key).remove();
  }
}