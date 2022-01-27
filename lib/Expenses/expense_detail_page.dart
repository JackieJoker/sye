import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:sye/Db/db.dart';
import 'package:sye/Groups/group.dart';
import 'edit_expense_page.dart';
import 'expense.dart';
import 'expense_detail.dart';

class ExpenseDetailPage extends StatelessWidget {
  final String _expenseId;
  final String _groupId;
  final Group _group;

  const ExpenseDetailPage({Key? key,
    required String groupId,
    required String expenseId,
    required Group group})
      : _expenseId = expenseId,
        _group = group,
        _groupId = groupId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if(DB.getExpense(_groupId, _expenseId) == null) {
      return const SizedBox.shrink();
    }
    return FirebaseDatabaseQueryBuilder(
        query: DB.getExpense(_groupId, _expenseId)!,
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
          final Expense _expense = Expense(
            expenseId: _expenseId,
            title: result["title"],
            emoji: '💙',
            payer: _group.getUsers()![result['payer']],
            amount: result["amount"],
            convertedAmount: result['converted_amount'],
            date: result["date"],
            currency: result['currency'],
            //TODO
            //type: result['type'],
            //category: result['category'],
            type: 'type',
            //delete
            category: 'category',
            //delete
            users: (result['users'] as Map).values.toList(),
          );
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(_expense.title),
              actions: [
                TextButton(
                  child: const Text(
                    "Edit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditExpensePage(
                                  groupId: _groupId,
                                  group: _group,
                                  expenseId: _expenseId,
                                )));
                  },
                )
              ],
            ),
            body: ExpenseDetail(
              expense: _expense,
              group: _group,
            ),
          );
        });
  }
}
