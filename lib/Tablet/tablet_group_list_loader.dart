import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:sye/Db/db.dart';
import 'package:sye/Expenses/expenses_list.dart';
import 'package:sye/Expenses/new_expense_page.dart';
import 'package:sye/Groups/group.dart';

class TabletGroupListLoader extends StatelessWidget {
  final String _groupId;

  const TabletGroupListLoader({required String g, Key? key})
      : _groupId = g,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseDatabaseQueryBuilder(
        query: DB.getGroup(_groupId),
        builder: (BuildContext context, FirebaseQueryBuilderSnapshot snapshot,
            Widget? child) {
          if (snapshot.isFetching) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          List<DataSnapshot> data = snapshot.docs;
          Map<String, dynamic> result = {};
          for (int i = 0; i < data.length; i++) {
            result.addAll({data[i].key!: data[i].value});
          }
          Group g = Group(
            id: _groupId,
            name: result["name"],
            currency: result["currency"],
            description: result["description"],
            users: result["participants"],
            expenses: result['expenses'],
            category: result['category'],
            creator: result['creator'],
          );
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewExpensePage(
                                  groupId: _groupId,
                                  groupCurrency: g.getCurrency(),
                                )));
                  },
                  tooltip: "Add a new expense",
                  child: const Icon(Icons.add)),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: ExpensesList(groupId: _groupId, group: g));
        });
  }
}
