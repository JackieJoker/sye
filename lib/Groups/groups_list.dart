import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:sye/Groups/group.dart';
import 'package:sye/Groups/group_visualizer.dart';
import 'package:sye/Classes/swipeable_item.dart';
import '../Db/db.dart';
import '../get_device_id.dart';

/*class GroupsList extends StatefulWidget {
  const GroupsList({Key? key}) : super(key: key);

  @override
  _GroupsListState createState() => _GroupsListState();
}

class _GroupsListState extends State<GroupsList> {
  final Future<DatabaseReference> _groups = DB.getGroups();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _groups,
      builder: (BuildContext context, AsyncSnapshot<DatabaseReference> snapshot) {
        Function _delete(String key) {
          return () => snapshot.data!.child(key).remove();
        }
        Widget child;
        if (snapshot.hasData) {
          DatabaseReference data = snapshot.data!;
          child = FirebaseDatabaseListView(
              query: data,
              itemBuilder: (context, snapshot1) {
                var group = snapshot1.value as Map;
                log(group.toString());
                return SwipeableItem(
                  item: GroupVisualizer(route: group, k: snapshot1.key!),
                  onDelete: _delete(snapshot1.key!),
                );
              },
            );
        } else if (snapshot.hasError) {
          /*children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];*/
          child = const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          );
          print(snapshot.error);
        } else {
          child = const
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            );
        }
        return Center(
            child: child,
        );
      }
    );
  }
}*/


/*class GroupsList extends StatelessWidget {
  const GroupsList({Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    DB.getGroups();
    return FirebaseDatabaseListView(
        query: DB.getGroup(),
        itemBuilder: (context, snapshot) {
          var group = snapshot.value as Map;
          return /*Text(group["name"]);*/
            SwipeableItem(
              item: GroupVisualizer(route: group, k: snapshot.key!),
              onDelete: _delete(snapshot.key!),
          );
        },
        );
  }

  Function _delete(String key) {
    return () => DB.getGroup().child(key).remove();
  }
}*/
class GroupsList extends StatelessWidget {
  const GroupsList({Key? key}) : super(key: key);


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
                return FirebaseDatabaseListView(
                  query: FirebaseDatabase.instance.ref('groups/' + groupId),
                  itemBuilder: (context, snapshot) {
                    var group = snapshot.value as Map;
                    return /*Text(group["name"]);*/
                      SwipeableItem(
                        item: GroupVisualizer(route: group, k: snapshot.key!),
                        onDelete: _delete(snapshot.key!),
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
