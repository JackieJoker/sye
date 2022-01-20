import 'package:flutter/material.dart';
import 'package:sye/Expenses/expenses_page.dart';
import 'package:sye/Groups/groups_list.dart';
import 'package:sye/Groups/new_group_form_page.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Split Your Expenses")
        )
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    //builder: (context) => NewGroupPage()));
            builder: (context) => NewGroupFormPage()));
          },
          tooltip: "Add a new expense",
          child: const Icon(Icons.add)),
      body: const GroupsList(),
    );
  }
}
