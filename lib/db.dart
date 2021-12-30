import 'package:firebase_database/firebase_database.dart';

abstract class DB {
  static final DatabaseReference _groups = FirebaseDatabase.instance.ref("groups");
  static final DatabaseReference _users = FirebaseDatabase.instance.ref("users");
  static final DatabaseReference _groupUsers = FirebaseDatabase.instance.ref("groups_users");
  static final DatabaseReference _userGroups = FirebaseDatabase.instance.ref("users_groups");

  static List<String> users = [];
  static List<String> userKeys = [];

  static DatabaseReference getExpensesList(String groupId) =>
      _groups.child(groupId + "/expenses");

  static DatabaseReference getUsersList(String groupId) =>
      _groups.child(groupId + '/participants');

  static Future<void> updateUsers(String groupId) async {
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

  static DatabaseReference getGroups() {
    return _groups;
  }
  //we need to perform a join fo each group to retrieve all the group data, e.g. expenses,name, partecipants etc..
}