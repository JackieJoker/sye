import 'package:flutter/material.dart';
import 'expenses_list.dart';

class ExpensesPage extends StatelessWidget {
  final String _groupId;

  const ExpensesPage({required String groupId, Key? key})
      : _groupId = groupId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpensesList(groupId: _groupId);
  }
}
