import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sye/Groups/group.dart';


class ExpenseUsersForm extends StatefulWidget {
  final Group _group;
  final FormGroup form;

  const ExpenseUsersForm({Key? key, required this.form, required Group group})
      : _group = group,
        super(key: key);

  @override
  _ExpenseUsersFormState createState() => _ExpenseUsersFormState();
}

class _ExpenseUsersFormState extends State<ExpenseUsersForm> {
  FormArray get usersList => widget.form.control('users') as FormArray;

  List<String> get users =>
      widget._group.getUsers()!.values.toList().cast<String>();

  @override
  void initState() {
    setUsers();
    super.initState();
  }

  Future<void> setUsers() async {
    if (usersList.value!.isEmpty) {
      usersList
          .addAll(users.map((e) => FormControl<bool>(value: true)).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: () => widget.form,
      builder: (context, form, child) {
        return ReactiveFormArray<bool>(
            formArrayName: 'users',
            builder: (context, formArray, child) {
              return Column(children: users.map(_buildUsersListItem).toList());
            });
      },
    );
  }

  Widget _buildUsersListItem(String user) {
    return ReactiveCheckboxListTile(
      formControlName: users.indexOf(user).toString(),
      title: Text(user),
    );
  }
}
