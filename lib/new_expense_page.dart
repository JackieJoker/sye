import 'package:flutter/material.dart';
import 'package:sye/expense_form.dart';

class NewExpensePage extends StatelessWidget {
  final String _groupId;
  const NewExpensePage({required String groupId, Key? key}) : _groupId = groupId, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New expense"),
        ),
        body: ExpenseForm(groupId: _groupId,),
    );
  }
}