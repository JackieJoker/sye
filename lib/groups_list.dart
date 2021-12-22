import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'db.dart';

class GroupsList extends StatelessWidget {
  final String _userId;
  const GroupsList({required String userId, Key? key})
      : _userId = userId,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return FirebaseDatabaseQueryBuilder(query: DB.getGroupsListByUser(_userId), builder: builder)
  }
}