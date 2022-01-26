import 'package:flutter/material.dart';
import 'package:sye/Groups/edit_group_page.dart';
import 'package:sye/Groups/group.dart';
import 'expenses_list.dart';
import 'new_expense_page.dart';

class ExpensesPage extends StatelessWidget {
  final String _groupId;
  final String _groupCurrency;
  final Group _group;

  const ExpensesPage(
      {required String groupId,
      required String groupCurrency,
      required Group group,
      Key? key})
      : _groupId = groupId,
        _groupCurrency = groupCurrency,
        _group = group,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> uList = castMapUsersToList(_group.getUsers()!);
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: const Icon(Icons.arrow_back_ios_outlined),
                onTap: () => Navigator.pop(context),
              ),
              Column(
                children: [
                  GestureDetector(
                    child: Text(_group.getName()),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => EditGroupPage(group: _group))
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(3.0),
                    child: Wrap(
                      children: List.generate(uList.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: Text(
                            uList[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
              const Icon(Icons.menu)
            ],
          )
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewExpensePage(
                            groupId: _groupId,
                            groupCurrency: _groupCurrency,
                          )));
            },
            tooltip: "Add a new expense",
            child: const Icon(Icons.add)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ExpensesList(groupId: _groupId, group: _group));
  }

  List<dynamic> castMapUsersToList (Map<dynamic,dynamic> m) {
    int i = 0;
    List<dynamic> l = [];
    while (m.containsKey('u' + i.toString())) {
      l.add(m['u' + i.toString()]);
      i += 1;
    }
    return l;
  }
}
