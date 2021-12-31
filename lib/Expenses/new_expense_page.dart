import 'package:flutter/material.dart';
import 'package:sye/Expenses/expense_form_page.dart';
import '../Db/db.dart';
import 'expense_form_model.dart';

class NewExpensePage extends StatelessWidget {
  final String _groupId;
  final String _groupCurrency;
  final ExpenseFormModel _model;

  NewExpensePage(
      {required String groupId,
      required String groupCurrency,
      Key? key})
      : _groupId = groupId,
        _groupCurrency = groupCurrency,
        _model = ExpenseFormModel(groupCurrency: groupCurrency),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpenseFormPage(groupId: _groupId, groupCurrency: _groupCurrency, onSubmit: _onSubmit, model: _model,);
  }

  void _onSubmit(Map edited) {
    final form = _model.form;
    DB.addExpense(_groupId, edited);
    form.reset();
  }
}
