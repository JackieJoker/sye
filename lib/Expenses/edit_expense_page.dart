import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:sye/Db/db.dart';
import 'package:sye/Expenses/expense_form_model.dart';
import 'package:sye/Groups/group.dart';
import 'package:intl/intl.dart';
import 'expense_form_page.dart';


class EditExpensePage extends StatelessWidget {
  final String _groupId;
  final Group _group;
  final String _expenseId;
  final ExpenseFormModel _model;

  EditExpensePage(
      {required String groupId, required Group group, required String expenseId, Key? key})
      : _groupId = groupId,
        _expenseId = expenseId,
        _group = group,
        _model = ExpenseFormModel(groupCurrency: group.getCurrency()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseDatabaseQueryBuilder(
        query: DB.getExpense(_groupId, _expenseId),
        builder:
            (BuildContext context, FirebaseQueryBuilderSnapshot snapshot,
            Widget? child) {
          if (snapshot.isFetching) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          _model.form.value = expenseForm(snapshot.docs);
          return ExpenseFormPage(groupId: _groupId, groupCurrency: _group.getCurrency(), model: _model, onSubmit: _onSubmit);
        });
  }

  Map<String, dynamic> expenseForm(List<DataSnapshot> data) {
    Map<String, dynamic> form = {};
    for(int i = 0; i < data.length; i++) {
      form.addAll({data[i].key! : data[i].value});
    }
    DateTime date = DateFormat('yyyy/MM/dd').parse(form['date']);
    form['date'] = date;
    Map<dynamic, dynamic> users = form['users'];
    List<bool> booleanUsers = _group.getUsers()!.keys.map((e) => users.containsKey(e)).toList();
    form['users'] = booleanUsers;
    form.remove('order');
    form['amount'] = form['amount'].toString();
    return form;
  }

  void _onSubmit(Map edited) {
    final form = _model.form;
    DB.editExpense(_groupId, _expenseId, edited);
    form.reset();
  }
}