import 'package:firebase_database/firebase_database.dart';

abstract class DB{
  static final DatabaseReference _groups = FirebaseDatabase.instance.ref("tricounts");
  //TODO: tricounts -> groups
  static final DatabaseReference _users = FirebaseDatabase.instance.ref("users");
  static final DatabaseReference _groupUsers = FirebaseDatabase.instance.ref("tricount_users");
  static final DatabaseReference _userGroups = FirebaseDatabase.instance.ref("users_groups");

  static DatabaseReference getExpensesList(String groupId){
    return _groups.child(groupId + "/expenses");
  }

  static getGroupsByUser(String userId, cb) {

  }
  //we need to perform a join fo each tricount to retrieve all the group data, e.g. expenses,name, partecipants etc..
}