import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sye/Db/db.dart';
import 'package:intl/intl.dart';
import 'package:sye/Groups/group.dart';
import 'expense_form.dart';
import 'expense_form_model.dart';

class ExpenseFormPage extends StatelessWidget {
  final Group _group;
  final ExpenseFormModel _model;
  final Function _onSubmit;

  const ExpenseFormPage(
      {required Group group,
      required Function onSubmit,
      required ExpenseFormModel model,
      Key? key})
      : _group = group,
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
        group: _group,
        model: _model,
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
    List<String> users = _group.getUsers()!.values.toList().cast<String>();
    List<String> usersKeys = _group.getUsers()!.keys.toList().cast<String>();

    final form = _model.form;
    List<bool?> usersBool = form.findControl('users')!.value as List<bool?>;
    Map<String, String> selectedUsers = {};

    for (int i = 0; i < usersBool.length; i++) {
      if (usersBool[i]!) selectedUsers[usersKeys[i]] = users[i];
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
    log(editedBalance.toString());
    DB.editBalance(editedBalance, _group.getId());
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