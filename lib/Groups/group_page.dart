import 'package:flutter/material.dart';
import 'package:sye/Expenses/expenses_page.dart';
import 'package:sye/Groups/groups_list.dart';
import 'package:sye/Groups/new_group_form_page.dart';
import 'package:sye/login.dart';

import '../auth_gate.dart';
import '../profile_page.dart';
import '../Db/db.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Center(
              child: Text("Split Your Expenses")
            ),
            GestureDetector(
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthGate()));},
                child: Icon(Icons.menu)
            )
          ],
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
      body: FutureBuilder(
        future: DB.checkUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool? condition = snapshot.data as bool;
            if (condition) {
              return const GroupsList();
            } else {
              DB.addUser();
              return const GroupsList();
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
