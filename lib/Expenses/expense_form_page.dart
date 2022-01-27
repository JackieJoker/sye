import 'package:flutter/material.dart';
import 'package:sye/Db/db.dart';
import 'package:intl/intl.dart';
import 'expense_form.dart';
import 'expense_form_model.dart';

class ExpenseFormPage extends StatelessWidget {
  final String _groupId;
  final String _groupCurrency;
  final ExpenseFormModel _model;
  final Function _onSubmit;

  const ExpenseFormPage(
      {required String groupId,
      required String groupCurrency,
      required Function onSubmit,
      required ExpenseFormModel model,
      Key? key})
      : _groupId = groupId,
        _groupCurrency = groupCurrency,
        _onSubmit = onSubmit,
        _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final form = _model.form;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                  if(_atLeastOneUserSelected()){
                    _onSubmit(_editForm());
                    Navigator.pop(context);
                  } else {

                  }
                } else {
                  form.markAllAsTouched();
                }
              })
        ]),
      ),
      body: ExpenseForm(
        groupId: _groupId,
        model: _model,
        groupCurrency: _groupCurrency,
      ),
    );
  }

  bool _atLeastOneUserSelected(){
    final form = _model.form;
    List<bool?> usersBool = form.findControl('users')!.value as List<bool?>;
    bool? logicalEnd = usersBool.reduce((value, element) => value! || element!);
    return logicalEnd!;
  }

  Map _editForm(){
    final form = _model.form;
    List<bool?> usersBool = form.findControl('users')!.value as List<bool?>;
    Map<String, String> selectedUsers = {};

    for (int i = 0; i < usersBool.length; i++) {
      if (usersBool[i]!) selectedUsers[DB.userKeys[i]] = DB.users[i];
    }
    Map? edited = Map.of(form.value);
    Map? editedBalance = {};
    String payer = form.findControl('payer')!.value;
    double bal = double.parse(form.findControl('amount')!.value);
    editedBalance[payer] = bal;
    selectedUsers.forEach((key, value) {
      if (key != payer) {
        editedBalance[key] = 0;
      }
    });
    editedBalance.forEach((user, value) {
       editedBalance.update(user, (value) => value - bal/editedBalance.length);
    });
    DB.editBalance(editedBalance, _groupId);
    print(editedBalance.toString());
    DateTime date = edited['date'];
    edited.update('users', (value) => selectedUsers) as Map?;
    edited.update('date', (value) => DateFormat('yyyy/MM/dd').format(value));
    edited.update('amount', (value) => double.parse(value));
    edited.addAll({'order': -date.millisecondsSinceEpoch});
    return edited;
  }
}

//TODO: optimize the balance adding