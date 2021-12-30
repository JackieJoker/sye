import 'package:flutter/material.dart';
import 'package:sye/expenses_page.dart';
import 'package:sye/groups_list.dart';
import 'package:sye/new_group_page.dart';

class TestHomePage extends StatelessWidget {
  const TestHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Split Your Expenses"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewGroupPage()));
          },
          tooltip: "Add a new expense",
          child: const Icon(Icons.add)),
      body: const GroupsList(),
    );
  }
}
