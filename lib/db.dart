import 'package:firebase_database/firebase_database.dart';

abstract class DB{
  static final DatabaseReference _groups = FirebaseDatabase.instance.ref("tricounts");
  //TODO: tricounts -> groups

  static DatabaseReference getExpensesList(String groupId){
    return _groups.child(groupId + "/expenses");
  }
}