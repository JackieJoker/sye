import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:sye/swipeable_item.dart';
import 'db.dart';
import 'expense.dart';

class ExpensesList extends StatelessWidget {
  final String _groupId;

  const ExpensesList({required String groupId, Key? key})
      : _groupId = groupId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseDatabaseListView(
      query: DB.getExpensesList(_groupId),
      itemBuilder: (context, snapshot) {
        var expense = snapshot.value as Map;
        return SwipeableItem(
          item: Expense(
            title: expense["title"],
            payer: expense["payer"],
            amount: expense["amount"],
            date: expense["date"],
          ),
          onDelete: _delete(snapshot.key!),
        );
      },
    );
  }

  Function _delete(String key) {
    return () => DB.getExpensesList(_groupId).child(key).remove();
  }
}
