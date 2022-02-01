import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sye/Expenses/new_expense_page.dart';
import 'package:sye/Groups/group.dart';

void main() {
  Group group = const Group(
      id: 'id', name: 'name', description: 'description', currency: 'EUR', users: {'u0': 'Danilo', 'u1': 'Alessandro'});

  testWidgets('Cancel button is present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: NewExpensePage(group: group)));

    ///I want to be sure that the cancel button is visualized
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('Cancel button triggers navigation after tapped',
      (WidgetTester tester) async {
        await tester.pumpWidget(
            MaterialApp(
                home: NewExpensePage(group: group)));

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
          home: NewExpensePage(group: group,)),
    );

    ///I want to be sure that the Save button is visualized
    expect(find.text('Save'), findsOneWidget);
  });

  testWidgets('Cancel button is present', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
          home: NewExpensePage(group: group,)),
    );

    ///I want to be sure that the Save button is visualized
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('Amount form is present', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
          home: NewExpensePage(group: group,)),
    );

    ///I want to be sure that the Save button is visualized
    expect(find.text('Amount'), findsOneWidget);
  });

  testWidgets('Save button doesnt triggers navigation after tapped if the form is incomplete',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
              home: NewExpensePage(group: group)),
        );

        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();

        ///I want to be sure that the new page is visualized
        expect(find.byType(NewExpensePage), findsOneWidget);

        ///I want to be sure that the old page is not anymore visualized
        expect(find.byType(MaterialPage), findsNothing);
      });
}
