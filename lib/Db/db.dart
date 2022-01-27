import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:sye/get_device_id.dart';

abstract class DB {
  static DatabaseReference _groups = FirebaseDatabase.instance.ref("groups");
  static final DatabaseReference _users = FirebaseDatabase.instance.ref("users");
  static final DatabaseReference _groupUsers = FirebaseDatabase.instance.ref("groups_users");
  static final DatabaseReference _userGroups = FirebaseDatabase.instance.ref("users_groups");


  static List<String> users = [];
  static List<String> userKeys = [];

  static downloadGroup() {}
  static Future<bool?> checkUser() async {
    String x = await DeviceId.getDeviceDetails();
    DatabaseReference check = _users.child(x);
    DatabaseEvent ev = await check.once();
    if (ev.snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }
  static Future<void> addUser() async {
    String x = await DeviceId.getDeviceDetails();
    _users.child(x).push();
    _userGroups.child(x).push();
  }
  static DatabaseReference? getExpensesList(String groupId) {
    getGroups();
    return _groups.child(groupId + "/expenses");
  }


  static DatabaseReference? getUsersList(String groupId) {
    getGroups();
    return _groups.child(groupId + '/participants');

  }

  static DatabaseReference? getExpense(String groupId, String expenseId) {
    getGroups();
    return _groups.child(groupId + "/expenses/" + expenseId);
  }

  static Future<void> updateUsers(String groupId) async {
    //This line is to make unit and widget testing without calling Firebase
    if(!Platform.environment.containsKey('FLUTTER_TEST')) {
      getGroups();
      DatabaseEvent event =
      await
      _groups
          .child(groupId + '/participants')
          .once();
      Map<dynamic, dynamic>? dbMap = event.snapshot.value as Map<
          dynamic,
          dynamic>?;
      List<String>? usersList = dbMap!.values.cast<String>().toList();
      users = usersList;
      List<String>? keysList = dbMap.keys.cast<String>().toList();
      userKeys = keysList;
    }
  }

  static Future<void> editBalance(Map balance, String x) async {
    String userId = await DeviceId.getDeviceDetails();
    DatabaseReference ref = FirebaseDatabase.instance.ref(userId + '/' + 'groups' + '/' + x + '/balances');
    DatabaseEvent bal = await ref.once();
    if (bal.snapshot.exists) {
      Map trueBalance = bal.snapshot.value as Map;
      trueBalance.forEach((key, value) {
        trueBalance.update(key, (value) => value + balance[key]);
      });
      ref.set(trueBalance);
    }
  }

  static void addExpense(String groupId, Map expense){
    DatabaseReference expensesDB = _groups.child(groupId + '/expenses');
    DatabaseReference newExpenseDB = expensesDB.push();
    newExpenseDB.set(expense);
  }

  static Future<void> addGroup(Map group) async {
    String userId = await DeviceId.getDeviceDetails();
    DatabaseReference join = _userGroups.child(userId);
    DatabaseReference newGroupDB = _groups.push();
    String? newGroupKey = newGroupDB.key;
    newGroupDB.set(group);
    join.set(newGroupKey);
  }

  static Future<void> editExpense(String groupId, String expenseId, Map expense) async {
    String userId = await DeviceId.getDeviceDetails();
    DatabaseReference groups = FirebaseDatabase.instance.ref(userId + '/groups');
    DatabaseReference expensesDB = groups.child(groupId + "/expenses/" + expenseId);
    expensesDB.set(expense);
  }

  static getGroups() async {
    //This line is to make unit and widget testing without calling Firebase
    if(!Platform.environment.containsKey('FLUTTER_TEST')){
      String userId = await DeviceId.getDeviceDetails();
      DatabaseReference groups = FirebaseDatabase.instance.ref(userId + '/groups');
      DatabaseEvent g = await groups.once();
      //setGroup(groups);
      if (g.snapshot.exists) {
        setGroup(groups);
      } else {
        groups.push();
        setGroup(groups);
      }
    }
  }

  static DatabaseReference getGroup() => _groups;

  static void setGroup(DatabaseReference x) { _groups = x; }

  static Future<void> deleteGroup(String x) async {
    String userId = await DeviceId.getDeviceDetails();
    DatabaseReference ref = FirebaseDatabase.instance.ref(userId + '/' + 'groups' + '/' + x);
    await ref.remove();
  }
  static Future<void> editGroup(String x, Map<String,Object?> m) async {
    String userId = await DeviceId.getDeviceDetails();
    DatabaseReference ref = FirebaseDatabase.instance.ref(userId + '/' + 'groups' + '/' + x);
    await ref.update(m); //
  }
  //we need to perform a join fo each group to retrieve all the group data, e.g. expenses,name, partecipants etc..


  /// Register a user if not present in DB
  static Future<void> registerUser(String firebaseId) async {
    String userId = await DeviceId.getDeviceDetails();
    DatabaseReference user = _users.child(userId + '/uid');
    user.set(firebaseId);
  }
}