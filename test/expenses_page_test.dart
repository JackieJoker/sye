import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sye/Expenses/expense.dart';
import 'package:sye/Expenses/expense_detail_page.dart';
import 'package:sye/Expenses/expense_element.dart';
import 'package:sye/Expenses/expenses_list.dart';
import 'package:sye/Expenses/expenses_page.dart';
import 'package:sye/Expenses/new_expense_page.dart';
import 'package:sye/Groups/group.dart';

void main() {
  Group group = const Group(
      id: 'id', name: 'name', description: 'description', currency: 'EUR');
  Expense expense = const Expense(
      expenseId: 'expenseId',
      title: 'title',
      emoji: 'emoji',
      payer: 'payer',
      amount: 1,
      date: 'date',
      category: 'category',
      currency: 'EUR',
      type: 'type',
      users: []);

  testWidgets('Add button is present', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ExpensesPage(
            groupId: 'groupId', groupCurrency: 'EUR', group: group),
      ),
    );

    ///I want to be sure that the add button is visualized
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Add button triggers navigation after tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ExpensesPage(
            groupId: 'groupId', groupCurrency: 'EUR', group: group),
      ),
    );

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    ///I want to be sure that the new page is visualized
    expect(find.byType(NewExpensePage), findsOneWidget);

    ///I want to be sure that the old page is not anymore visualized
    expect(find.byType(ExpensesPage), findsNothing);
  });

  testWidgets('ExpensesList is present', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ExpensesPage(
            groupId: 'groupId', groupCurrency: 'EUR', group: group),
      ),
    );

    ///I want to be sure that the add button is visualized
    expect(find.byType(ExpensesList), findsOneWidget);
  });

  testWidgets('Elements contains all required infos',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            appBar: AppBar(),
            body: ExpenseElement(
                groupId: 'groupId', expense: expense, group: group))));

    ///I want to be sure that the info are visualized
    expect(find.text(expense.title), findsOneWidget);
    expect(find.text(expense.payer), findsOneWidget);
    expect(find.text(expense.date), findsOneWidget);
    expect(find.textContaining(expense.amount.toString()), findsOneWidget);
  });

  testWidgets('Tap on one element triggers navigation',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ExpenseElement(
                groupId: 'groupId', expense: expense, group: group))));

    await tester.tap(find.byType(ExpenseElement));
    await tester.pumpAndSettle();

    ///I want to be sure that the new page is visualized
    expect(find.byType(ExpenseDetailPage), findsOneWidget);

    ///I want to be sure that the old page is not anymore visualized
    expect(find.byType(ExpenseElement), findsNothing);
  });
}
