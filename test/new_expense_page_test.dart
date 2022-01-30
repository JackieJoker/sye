import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sye/Expenses/new_expense_page.dart';

void main() {

  testWidgets('Cancel button is present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: NewExpensePage(groupId: 'groupId', groupCurrency: 'EUR')));

    ///I want to be sure that the cancel button is visualized
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('Cancel button triggers navigation after tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
          home: NewExpensePage(groupId: 'groupId', groupCurrency: 'EUR')),
    );

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    ///I want to be sure that the new page is visualized
    expect(find.byType(MaterialApp), findsOneWidget);

    ///I want to be sure that the old page is not anymore visualized
    expect(find.byType(NewExpensePage), findsNothing);
  });

  testWidgets('Save button is present', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
          home: NewExpensePage(groupId: 'groupId', groupCurrency: 'EUR')),
    );

    ///I want to be sure that the Save button is visualized
    expect(find.text('Save'), findsOneWidget);
  });

  testWidgets('Amount form cuts off all the letters', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
          home: NewExpensePage(groupId: 'groupId', groupCurrency: 'EUR')),
    );

    await tester.enterText(find.widgetWithText(ReactiveTextField, 'Title'), 'x');
    await tester.enterText(find.widgetWithText(ReactiveTextField, 'Amount'), 'az1gsh0____9');

    /// Cuts off all the letters
    expect(find.text('109'), findsOneWidget);

  });

  testWidgets('Amount admit only numbers and . (DOT) ', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
          home: NewExpensePage(groupId: 'groupId', groupCurrency: 'EUR')),
    );

    await tester.enterText(find.widgetWithText(ReactiveTextField, 'Title'), 'x');
    await tester.enterText(find.widgetWithText(ReactiveTextField, 'Amount'), '+-^!"£%&/()1=é*§°ç.5,-_+*');

    /// Cuts off all the symbols (includin mathematical ones)
    expect(find.text('1.5'), findsOneWidget);
  });

  testWidgets('Save button doesnt triggers navigation after tapped if the form is incomplete',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
              home: NewExpensePage(groupId: 'groupId', groupCurrency: 'EUR')),
        );

        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();

        ///I want to be sure that the new page is visualized
        expect(find.byType(NewExpensePage), findsOneWidget);

        ///I want to be sure that the old page is not anymore visualized
        expect(find.byType(MaterialPage), findsNothing);
      });
}
