import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sye/Expenses/expense.dart';
import 'package:sye/Expenses/expense_detail.dart';
import 'package:sye/Groups/group.dart';

void main() {
  Group group = const Group(
    id: 'id',
    name: 'name',
    description: 'description',
    currency: 'EUR',
  );

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

  testWidgets('All important details are present', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ExpenseDetail(
          group: group,
          expense: expense,
        ),
      ),
    );

    expect(find.text(expense.date), findsOneWidget);
    expect(find.text(expense.payer), findsOneWidget);
    expect(find.textContaining(expense.amount.toString()), findsOneWidget);
  });
}
