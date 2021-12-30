import 'package:flutter/material.dart';
import 'package:sye/Groups/group.dart';
import 'expense.dart';
import 'expense_detail.dart';

class ExpenseDetailPage extends StatelessWidget {
  final Expense _expense;
  final Group _group;

  const ExpenseDetailPage({Key? key, required Expense expense, required Group group})
      : _expense = expense,
        _group = group,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_expense.title),
      ),
      body: ExpenseDetail(
        expense: _expense,
        group: _group,
      ),
    );
  }
}
