import 'package:flutter/material.dart';
import 'package:sye/Groups/group.dart';
import 'expenses_list.dart';
import 'new_expense_page.dart';

class ExpensesPage extends StatelessWidget {
  final String _groupId;
  final String _groupCurrency;
  final Group _group;

  const ExpensesPage(
      {required String groupId,
      required String groupCurrency,
      required Group group,
      Key? key})
      : _groupId = groupId,
        _groupCurrency = groupCurrency,
        _group = group,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: const Icon(Icons.arrow_back_ios_outlined),
                onTap: () => Navigator.pop(context),
              ),
              GestureDetector(
                child: Text(_group.getName()),
              ),
              const Icon(Icons.menu)
            ],
          )
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewExpensePage(
                            groupId: _groupId,
                            groupCurrency: _groupCurrency,
                          )));
            },
            tooltip: "Add a new expense",
            child: const Icon(Icons.add)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ExpensesList(groupId: _groupId, group: _group));
  }
}
