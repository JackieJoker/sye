import 'package:flutter/material.dart';
import 'expenses_list.dart';
import 'new_expense_page.dart';

class ExpensesPage extends StatelessWidget {
  final String _groupId;

  const ExpensesPage({required String groupId, Key? key})
      : _groupId = groupId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Split Your Expenses"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewExpensePage(groupId: _groupId)));
          },
          tooltip: "Add a new expense",
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ExpensesList(groupId: _groupId)
    );
  }
}
