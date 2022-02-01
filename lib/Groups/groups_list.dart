import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:sye/Groups/group.dart';
import 'package:sye/Groups/group_visualizer.dart';
import 'package:sye/Classes/swipeable_item.dart';
import '../Db/db.dart';
import '../get_device_id.dart';

class GroupsList extends StatelessWidget {
  final _notifier;

  const GroupsList({Key? key, notifier}) : _notifier = notifier, super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getId(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String? id = snapshot.data as String;
            return FirebaseDatabaseListView(
              query: FirebaseDatabase.instance.ref("users_groups/" + id),
              itemBuilder: (context, userSnapshot) {
                String groupId = userSnapshot.key!;
                return FirebaseDatabaseQueryBuilder(
                  query: FirebaseDatabase.instance.ref('groups/' + groupId),
                  builder: (BuildContext context,
                      FirebaseQueryBuilderSnapshot userSnapshot, Widget? child) {
                    if (userSnapshot.isFetching) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (userSnapshot.hasError) {
                      return Text('Error: ${userSnapshot.error}');
                    }
                    //var group = userSnapshot.docs as Map;
                    List<DataSnapshot> data = userSnapshot.docs;
                    Map<String, dynamic> group = {};
                    for (int i = 0; i < data.length; i++) {
                      group.addAll({data[i].key!: data[i].value});
                    }
                    return Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.teal,
                        child: SwipeableItem(
                          item: GroupVisualizer(route: group, k: groupId, notifier: _notifier,),
                          onDelete: _delete(groupId),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        }
    );
  }

  Function _delete(String key) {
    return () => DB.deleteGroup(key);
  }

  Future<String?> getId() async {
    var id = await DeviceId.getDeviceDetails();
    return id;
  }
}
