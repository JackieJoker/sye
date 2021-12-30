import 'package:flutter/material.dart';
import 'expense.dart';
import 'expense_detail.dart';

class ExpenseDetailPage extends StatelessWidget {
  final Expense _expense;

  const ExpenseDetailPage({Key? key, required Expense expense})
      : _expense = expense,
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
      ),
    );
  }
}
