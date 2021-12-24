import 'package:flutter/material.dart';
import 'package:sye/expense_form.dart';

import 'db.dart';
import 'expense_form_model.dart';

class NewExpensePage extends StatelessWidget {
  final String _groupId;

  final ExpenseFormModel _model = ExpenseFormModel();

  NewExpensePage({required String groupId, Key? key})
      : _groupId = groupId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final form = _model.form;
    return Scaffold(
      appBar: AppBar(
        title: const Text("New expense"),
        actions: <Widget>[
          TextButton(
              child: const Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (form.valid) {
                  _onSubmit();
                  Navigator.pop(context);
                } else {
                  form.markAllAsTouched();
                }
              })
        ],
      ),
      body: ExpenseForm(groupId: _groupId, model: _model),
    );
  }

  void _onSubmit() {
    final form = _model.form;
    List<bool?> usersBool = form.findControl('users')!.value as List<bool?>;
    Map<String, String> selectedUsers = {};
    for (int i = 0; i < usersBool.length; i++) {
      if (usersBool[i]!) selectedUsers[DB.userKeys[i]] = DB.users[i];
    }
    Map? edited = Map.of(form.value);
    edited.update('users', (value) => selectedUsers) as Map?;
    edited.update('date', (value) => value.toString());
    edited.update('amount', (value) => double.parse(value));
    DB.addExpense(_groupId, edited);
    form.reset();
  }
}
