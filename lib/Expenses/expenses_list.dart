import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:sye/Classes/swipeable_item.dart';
import 'package:sye/Groups/group.dart';
import '../Db/db.dart';
import 'expense.dart';
import 'expense_element.dart';

class ExpensesList extends StatelessWidget {
  final String _groupId;
  final Group _group;

  const ExpensesList({required String groupId, required Group group, Key? key})
      : _groupId = groupId,
        _group = group,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseDatabaseListView(
      query: DB.getExpensesList(_groupId).orderByChild('order'),
      itemBuilder: (context, snapshot) {
        var expense = snapshot.value as Map;
        return SwipeableItem(
          item: ExpenseElement(
            expense: Expense(
              title: expense["title"],
              emoji: '💙',
              payer: _group.getUsers()![expense['payer']],
              amount: expense["amount"],
              convertedAmount: expense['converted_amount'],
              date: expense["date"],
              currency: expense['currency'],
              //TODO
              //type: expense['type'],
              //category: expense['category'],
              type: 'type',
              //delete
              category: 'category',
              //delete
              users: (expense['users'] as Map).values.toList(),
            ),
            group: _group,
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
