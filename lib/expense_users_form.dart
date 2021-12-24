import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'db.dart';

class ExpenseUsersForm extends StatefulWidget {
  final String _groupId;
  final FormGroup form;

  const ExpenseUsersForm({Key? key, required this.form, required groupId}) : _groupId = groupId, super(key: key);

  @override
  _ExpenseUsersFormState createState() => _ExpenseUsersFormState();
}

class _ExpenseUsersFormState extends State<ExpenseUsersForm> {
  FormArray get usersList => widget.form.control('users') as FormArray;

  @override
  void initState() {
    setUsers();
    super.initState();
  }

  Future<void> setUsers() async {
    if(DB.users.isEmpty) {
      await DB.updateUsers(widget._groupId);
    }
    usersList.addAll(
        DB.users.map((e) => FormControl<bool>(value: true)).toList()
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: () => widget.form,
      builder: (context, form, child) {
        return ReactiveFormArray<bool>(
          formArrayName: 'users',
          builder: (context, formArray, child) => Column(
              children: DB.users.map(_buildUsersListItem).toList()),
        );
      },
    );
  }

  Widget _buildUsersListItem(String user) {
    return ReactiveCheckboxListTile(
      formControlName: DB.users.indexOf(user).toString(),
      title: Text(user),
    );
  }
}