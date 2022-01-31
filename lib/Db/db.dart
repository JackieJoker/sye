import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:sye/get_device_id.dart';

abstract class DB {
  static final DatabaseReference _groups = FirebaseDatabase.instance.ref("groups");
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
    DatabaseReference newUser = _users.child(x);
    newUser.set({'name' :'', 'email' : ''});
  }

  static DatabaseReference? getExpensesList(String groupId) {
    //This line is to make unit and widget testing without calling Firebase
    if(Platform.environment.containsKey('FLUTTER_TEST')) {
      return null;
    }
    return _groups.child(groupId + "/expenses");
  }


  static DatabaseReference? getUsersList(String groupId) {
    //This line is to make unit and widget testing without calling Firebase
    if(Platform.environment.containsKey('FLUTTER_TEST')) {
      return null;
    }
    return _groups.child(groupId + '/participants');
  }

  static Future<bool> isGroupPresent(String groupId) async {
    DataSnapshot group = await _groups.child(groupId).get();
    if (group.exists) {
      return true;
    } else{
      return false;
    }
  }

  static DatabaseReference? getExpense(String groupId, String expenseId) {
    //This line is to make unit and widget testing without calling Firebase
    if(Platform.environment.containsKey('FLUTTER_TEST')) {
      return null;
    }
    return _groups.child(groupId + "/expenses/" + expenseId);
  }

  static Future<void> updateUsers(String groupId) async {
    //This line is to make unit and widget testing without calling Firebase
    if(!Platform.environment.containsKey('FLUTTER_TEST')) {
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
    DatabaseReference ref = FirebaseDatabase.instance.ref('groups/' + x + '/balances');
    DatabaseEvent bal = await ref.once();
    if (bal.snapshot.exists) {
      Map trueBalance = bal.snapshot.value as Map;
      trueBalance.forEach((key, value) {
        if (balance.containsKey(key)) {
          trueBalance.update(key, (value) => value + balance[key]);
        } else {
          trueBalance.update(key, (value) => value);
        }
      });
      ref.set(trueBalance);
    }
  }

  static void addExpense(String groupId, Map expense){
    DatabaseReference expensesDB = _groups.child(groupId + '/expenses');
    DatabaseReference newExpenseDB = expensesDB.push();
    newExpenseDB.set(expense);
  }

  static Future<void> addGroups(Map group) async {
    String userId = await DeviceId.getDeviceDetails();
    DatabaseReference join = _userGroups.child(userId);
    DatabaseReference newGroupDB = _groups.push();
    String? newGroupKey = newGroupDB.key;
    newGroupDB.set(group);
    join.child(newGroupKey!).set(group['name']);
  }

  static Future<void> importGroup(String groupId) async {
    String userId = await DeviceId.getDeviceDetails();
    DatabaseReference join = _userGroups.child(userId);
    DataSnapshot group = await _groups.child(groupId).get();
    join.child(groupId).set((group.value! as Map)['name']);
  }

  static Future<void> editExpense(String groupId, String expenseId, Map expense) async {
    String userId = await DeviceId.getDeviceDetails();
    DatabaseReference groups = FirebaseDatabase.instance.ref(userId + '/groups');
    DatabaseReference expensesDB = groups.child(groupId + "/expenses/" + expenseId);
    expensesDB.set(expense);
  }

  static DatabaseReference getGroup(String groupId) {
    return _groups.child(groupId);
  }
  
  static DatabaseReference getGroupBalances(String groupId) {
    return _groups.child(groupId).child('balances');
  }

  //static void setGroup(DatabaseReference x) { _groups = x; }
  static void deleteExpense(String x, String k, Map m) {
    DB.editBalance(m, x);
    DB.getExpensesList(x)!.child(k).remove();
  }

  static Future<void> deleteGroup(String x) async {
    String userId = await DeviceId.getDeviceDetails();
    DatabaseReference ref = _userGroups.child(userId).child(x);
    await ref.remove();
  }
  static Future<void> editGroup(String x, Map<String,Object?> m, Map<String,Object?> bal) async {
    DatabaseReference ref = _groups.child(x);
    DatabaseReference balances = ref.child('balances');
    await ref.update(m);
    await balances.update(bal);
  }
  //we need to perform a join fo each group to retrieve all the group data, e.g. expenses,name, partecipants etc..

  /// Register a user if not present in DB
  static Future<void> registerUser(String firebaseId) async {
    String userId = await DeviceId.getDeviceDetails();
    DatabaseReference user = _users.child(userId + '/uid');
    user.set(firebaseId);
  }

  static Future<Map> getTotalGroupBalances(String groupId) async {
    Map totalBalances = {};
    DatabaseReference expenses = _groups.child(groupId).child('expenses');
    DatabaseEvent expList = await expenses.once();
    Map exp = expList.snapshot.value as Map;
    if (expList.snapshot.exists) {
      exp.forEach((key, value) {
        if (totalBalances.containsKey(value['payer'])) {
          totalBalances.update(value['payer'], (val) => val + value['amount']*1.00);
        } else {
          totalBalances.addAll({value['payer'] : value['amount']*1.00});
        }
      });
    }
    return totalBalances;
  }

  /*static Future<List> joinIdNameUser (String groupId, List ids) async {
    List names = [];
    for (var element in ids) {
      DatabaseReference userRef = FirebaseDatabase.instance.ref(groupId + '/participants/' + element);
      DatabaseEvent userName = await userRef.once();
      Map? mapData = userName.snapshot.value as Map;
      log(mapData.toString());
      if (userName.snapshot.exists) {
        names.add(mapData[element]);
      }
    }
    return names;
  }*/
}