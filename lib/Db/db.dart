import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:sye/get_device_id.dart';

abstract class DB {
  static var _groups;
  static final DatabaseReference _users = FirebaseDatabase.instance.ref("users");
  static final DatabaseReference _groupUsers = FirebaseDatabase.instance.ref("groups_users");
  static final DatabaseReference _userGroups = FirebaseDatabase.instance.ref("users_groups");


  static List<String> users = [];
  static List<String> userKeys = [];


  static DatabaseReference getExpensesList(String groupId) {
    getGroups();
    return _groups.child(groupId + "/expenses");
  }


  static DatabaseReference getUsersList(String groupId) {
    getGroups();
    return _groups.child(groupId + '/participants');

  }

  static DatabaseReference getExpense(String groupId, String expenseId) {
    getGroups();
    return _groups.child(groupId + "/expenses/" + expenseId);
  }

  static Future<void> updateUsers(String groupId) async {
    getGroups();
    DatabaseEvent event =
    await
    _groups
        .child(groupId + '/participants')
        .once();
    Map<dynamic, dynamic>? dbMap = event.snapshot.value as Map<dynamic, dynamic>?;
    List<String>? usersList = dbMap!.values.cast<String>().toList();
    users = usersList;
    List<String>? keysList = dbMap.keys.cast<String>().toList();
    userKeys = keysList;
  }

  static void addExpense(String groupId, Map expense){
    DatabaseReference expensesDB = _groups.child(groupId + '/expenses');
    DatabaseReference newExpenseDB = expensesDB.push();
    newExpenseDB.set(expense);
  }

  static void addGroup(Map group){
    DatabaseReference newGroupDB = _groups.push();
    newGroupDB.set(group);
  }

  static void editExpense(String groupId, String expenseId, Map expense){
    DatabaseReference expensesDB = _groups.child(groupId + "/expenses/" + expenseId);
    expensesDB.set(expense);
  }

  static getGroups() async {
    String userId = await DeviceId.getDeviceDetails();
    DatabaseReference groups = FirebaseDatabase.instance.ref(userId + '/groups');
    DatabaseEvent g = await groups.once();
    if (g.snapshot.exists) {
      setGroup(groups);
    } else {
      groups.push();
      setGroup(groups);
    }
  }

  static DatabaseReference getGroup() => _groups;
  static void setGroup(DatabaseReference x) { _groups = x; }
  //we need to perform a join fo each group to retrieve all the group data, e.g. expenses,name, partecipants etc..
}