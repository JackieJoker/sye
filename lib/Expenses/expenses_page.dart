import 'package:flutter/material.dart';
import 'package:sye/Groups/edit_group_page.dart';
import 'package:sye/Groups/group.dart';
import 'package:sye/Groups/group_stats.dart';
import '../balances_page.dart';
import 'expenses_list.dart';
import 'new_expense_page.dart';

class ExpensesPage extends StatefulWidget {
  final Group _group;

  const ExpensesPage({required Group group, Key? key})
      : _group = group,
        super(key: key);

  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getBody() {
    if (_selectedIndex == 0) {
      return ExpensesList(groupId: widget._group.getId(), group: widget._group);
    } else {
      return BalancesPage(
          widget._group.getId(), widget._group.getCurrency(), widget._group);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic>? uList;
    if (widget._group.getUsers() == null) {
      uList = null;
    } else {
      uList = castMapUsersToList(widget._group.getUsers()!);
    }
    return Scaffold(
        appBar: MediaQuery.of(context).orientation == Orientation.landscape ? null : AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: const Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 20,
                  ),
                  onTap: () => Navigator.pop(context),
                ),
                Column(
                  children: [
                    GestureDetector(
                      child: Text(widget._group.getName()),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditGroupPage(group: widget._group))),
                    ),
                    (uList == null)
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Wrap(
                              children: List.generate(uList.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 7),
                                  child: Text(
                                    uList![index],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13),
                                  ),
                                );
                              }),
                            ),
                          )
                  ],
                ),
                GestureDetector(
                    child: const Icon(Icons.menu),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditGroupPage(group: widget._group)));
                    })
              ],
            )),
        floatingActionButton: (_selectedIndex == 0)
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewExpensePage(
                                group: widget._group,
                              )));
                },
                tooltip: "Add a new expense",
                child: const Icon(Icons.add))
            : SizedBox(
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GroupStats(g: widget._group)));
                  },
                  label: const Text('Group Stats'),
                  icon: const Icon(Icons.stacked_bar_chart),
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money_rounded),
              label: 'Expenses',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_rounded),
              label: 'Balances',
            ),
          ],
        ),
        body: getBody());
  }

  List<dynamic> castMapUsersToList(Map<dynamic, dynamic> m) {
    int i = 0;
    List<dynamic> l = [];
    while (m.containsKey('u' + i.toString())) {
      l.add(m['u' + i.toString()]);
      i += 1;
    }
    return l;
  }
}
