import 'package:flutter/material.dart';
import 'package:sye/balances_page.dart';

import 'Expenses/expenses_page.dart';
import 'Groups/group.dart';

class TabletLayout extends StatelessWidget {
  final String _groupId;
  final String _groupCurrency;
  final Group _group;

  const TabletLayout(
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
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: MaterialApp(
            title: 'Split Your Expenses',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: ExpensesPage(
              groupId: _groupId,
              groupCurrency: _groupCurrency,
              group: _group,
            ),
          ),
        ),
        const Flexible(
          flex: 1,
          child: BalancesPage(),
        )
      ],
    );
  }
}
