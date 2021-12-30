import 'package:flutter/material.dart';
import 'package:sye/expenses_page.dart';

class HomePage extends StatelessWidget {
  static String _groupId = 't1';
  static String _groupCurrency = 'USD';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpensesPage(groupId: _groupId, groupCurrency: _groupCurrency,);
  }
}
