import 'package:flutter/material.dart';
import 'package:sye/Groups/group_form.dart';

import '../Db/db.dart';
import 'group_form_model.dart';

class NewGroupPage extends StatelessWidget {
  //final String _userId;

  final GroupFormModel _model = GroupFormModel();

  NewGroupPage({Key? key})
      : super(key: key);

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
              const Text("New Group"),
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
      body: GroupForm(model: _model),
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
    //DB.addExpense(_groupId, edited);
    form.reset();
  }
}