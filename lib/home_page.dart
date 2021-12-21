import 'package:flutter/material.dart';
import 'package:sye/expenses_page.dart';
import 'package:sye/new_expense_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Split Your Expenses"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NewExpensePage()));
          },
          tooltip: "Add a new expense",
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: const ExpensesPage(groupId: "t1"),
    );
  }
}
