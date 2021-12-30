import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:sye/Classes/swipeable_item.dart';
import '../Db/db.dart';
import 'expense.dart';
import 'expense_element.dart';

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
          item: ExpenseElement(
            expense: Expense(
              title: expense["title"],
              emoji: '💙',
              payer: expense["payer"],
              amount: expense["amount"],
              date: expense["date"],
              currency: expense['currency'],
              //TODO
              //type: expense['type'],
              //category: expense['category'],
              type: 'type',//
              category: 'category',//
              users: (expense['users'] as Map).values.toList(),
            ),
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
