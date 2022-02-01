import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sye/Expenses/expenses_page.dart';
import 'package:sye/Groups/group.dart';

void main() async {

  Group group = const Group(
      id: '01',
      name: 'name',
      description: 'description',
      currency: 'currency',
      category: 'category',
      users: {'u0' : 'user0', 'u1' : 'user1'}
  );

  testWidgets('Check the presence of the bottom navigation', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ExpensesPage(
            group: group),
      ),
    );

    ///I want to be sure that the add button is visualized
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });

  testWidgets('Check the presence of the balance tab', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ExpensesPage(
            group: group),
      ),
    );

    ///I want to be sure that the add button is visualized
    expect(find.byIcon(Icons.account_balance_wallet_rounded), findsOneWidget);
  });

  /*testWidgets('Check the visualization of the chart', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BalancesPage(group.getId(), group.getCurrency(), group),
          ),
        )
    );

    expect(find.byType(SfCartesianChart), findsOneWidget);
  });*/
}