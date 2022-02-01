import 'package:flutter/material.dart';
import 'package:sye/Expenses/expense_form_page.dart';
import 'package:sye/Groups/group.dart';
import '../Db/db.dart';
import 'expense_form_model.dart';

class NewExpensePage extends StatelessWidget {
  final Group _group;
  final ExpenseFormModel _model;

  NewExpensePage(
      {required Group group,
      Key? key})
      : _group = group,
        _model = ExpenseFormModel(groupCurrency: group.getCurrency()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpenseFormPage(group: _group, onSubmit: _onSubmit, model: _model,);
  }

  void _onSubmit(Map edited) {
    final form = _model.form;
    DB.addExpense(_group.getId(), edited);
    form.reset();
  }
}
