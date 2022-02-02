import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:sye/get_device_id.dart';

abstract class DB {
  static final DatabaseReference _groups = FirebaseDatabase.instance.ref("groups");
  static final DatabaseReference _users = FirebaseDatabase.instance.ref("users");
  static final DatabaseReference _userGroups = FirebaseDatabase.instance.ref("users_groups");



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

  // static Future<void> updateUsers(String groupId) async {
  //   //This line is to make unit and widget testing without calling Firebase
  //   if(!Platform.environment.containsKey('FLUTTER_TEST')) {
  //     DatabaseEvent event =
  //     await
  //     _groups
  //         .child(groupId + '/participants')
  //         .once();
  //     Map<dynamic, dynamic>? dbMap = event.snapshot.value as Map<
  //         dynamic,
  //         dynamic>?;
  //     List<String>? usersList = dbMap!.values.cast<String>().toList();
  //     users = usersList;
  //     List<String>? keysList = dbMap.keys.cast<String>().toList();
  //     userKeys = keysList;
  //   }
  // }

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
    DatabaseReference expensesDB = _groups.child(groupId + "/expenses/" + expenseId);
    expensesDB.set(expense);
  }

  static DatabaseReference getGroup(String groupId) {
    return _groups.child(groupId);
  }

  //static void setGroup(DatabaseReference x) { _groups = x; }
  static void deleteExpense(String x, String k) {
    DB.getExpensesList(x)!.child(k).remove();
  }

  static Future<void> deleteGroup(String x) async {
    String userId = await DeviceId.getDeviceDetails();
    DatabaseReference ref = _userGroups.child(userId).child(x);
    await ref.remove();
  }
  static Future<void> editGroup(String x, Map<String,Object?> m) async {
    DatabaseReference ref = _groups.child(x);
    await ref.update(m);
  }

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

  static Future<Map> getBalances(String groupId) async {
    Map<String,double> balances = {};
    DatabaseReference expenses = _groups.child(groupId).child('expenses');
    DatabaseReference participants = _groups.child(groupId).child('participants');
    DatabaseEvent expList = await expenses.once();
    DatabaseEvent participantsData = await participants.once();
    Map expMap = expList.snapshot.value as Map;
    Map parMap = participantsData.snapshot.value as Map;
    /// initialize the balances with all the participants of the group
    parMap.forEach((key, value) {
      balances.addAll({key : 0.0});
    });
    /// then for each expense we calculate the balances
    expMap.forEach((key, value) {
      /// download each expense from the db
      Map expense = value as Map;
      Map expenseUsers = expense['users'] as Map;
      String payer = expense['payer'];
      var amount = expense['amount'];
      balances.update(payer, (value) => value + amount);
      expenseUsers.forEach((key, value) {
        balances.update(key, (val) => val - amount/expenseUsers.length);
      });
    });
    return balances;
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