import 'package:flutter/material.dart';
import 'package:sye/Expenses/expense_form.dart';
import 'package:intl/intl.dart';
import '../Db/db.dart';
import 'expense_form_model.dart';

class NewExpensePage extends StatelessWidget {
  final String _groupId;
  final String _groupCurrency;

  final ExpenseFormModel _model;

  NewExpensePage({required String groupId, required String groupCurrency, Key? key})
      : _groupId = groupId,
        _groupCurrency = groupCurrency,
        _model = ExpenseFormModel(groupCurrency: groupCurrency),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final form = _model.form;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          TextButton(
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          const Text("New expense"),
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
        ]),
      ),
      body: ExpenseForm(groupId: _groupId, model: _model, groupCurrency: _groupCurrency,),
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
    edited.update('date', (value) => DateFormat('dd/MM/yyyy').format(value));
    edited.update('amount', (value) => double.parse(value));
    DB.addExpense(_groupId, edited);
    form.reset();
  }
}
