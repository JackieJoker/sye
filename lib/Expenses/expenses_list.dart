import 'dart:developer';

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
    if(DB.getExpensesList(_groupId) == null) {
      return const SizedBox.shrink();
    }
    return FirebaseDatabaseListView(
      query: DB.getExpensesList(_groupId)!.orderByChild('order'),
      itemBuilder: (context, snapshot) {
        var expense = snapshot.value as Map;
        String payer = expense['payer'];
        Map users = expense['users'] as Map;
        Map remBal = {};
        remBal.addAll({payer : (-expense['amount'] + expense['amount']/users.length)});
        users.forEach((key, value) {
          if (key != payer) {
            remBal.addAll({key : expense['amount']/users.length});
          }
        });
        return Padding(
          padding: const EdgeInsets.all(7.0),
          child: Card(
            elevation: 10,
            shadowColor: Colors.teal,
            child: SwipeableItem(
              item: ExpenseElement(
                expense: Expense(
                  expenseId: snapshot.key!,
                  title: expense["title"],
                  emoji: '💙',
                  //payer: expense["payer"], // mi da problemi con il modo in cui tu inserisci il payer, ho optato per questa soluzione al momento
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
                groupId: _groupId,
              ),
              onDelete: _delete(snapshot.key!, remBal),
            ),
          ),
        );
      },
    );
  }

  Function _delete(String key, Map m) {
    return () => DB.deleteExpense(_groupId, key, m);
  }
}
