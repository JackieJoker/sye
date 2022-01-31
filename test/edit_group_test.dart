import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sye/Expenses/expenses_page.dart';
import 'package:sye/Groups/edit_group_page.dart';
import 'package:sye/Groups/group.dart';
import 'package:sye/Groups/group_page.dart';
import 'package:sye/Groups/groups_list.dart';
import 'package:sye/Groups/new_group_form_page.dart';

void main() {
  Group group = const Group(
      id: '01',
      name: 'name',
      description: 'description',
      currency: 'currency',
      category: 'category',
      users: {'u0' : 'user0', 'u1' : 'user1'}
  );

  testWidgets('Check the existence of the cancel button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: EditGroupPage(group: group))),
    );
    /// I want to find the two text elements
    expect(find.widgetWithText(GestureDetector, 'Cancel'), findsOneWidget);
  });

  testWidgets('Check the existence of the edit button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: EditGroupPage(group: group))),
    );
    /// I want to find the two text elements
    expect(find.widgetWithText(GestureDetector, 'Save'), findsOneWidget);
  });

  testWidgets('Check the go back function of Cancel button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: EditGroupPage(group: group))),
    );
    await tester.tap(find.widgetWithText(GestureDetector, 'Cancel'));
    await tester.pumpAndSettle();

    ///I want to be sure that the new page is visualized
    expect(find.byType(ExpensesPage), findsOneWidget);

    ///I want to be sure that the old page is not anymore visualized
    expect(find.byType(NewGroupFormPage), findsNothing);
  });

  testWidgets('Check the display of the Add button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: EditGroupPage(group: group))),
    );

    expect(find.text('Add'), findsOneWidget);
  });

  testWidgets('Check the adding of a new user in the list', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: EditGroupPage(group: group))),
    );

    /// Enter the user Ale in the Text Field
    await tester.enterText(find.byKey(const Key('01')), 'Ale');
    /// Check if it shows up
    expect(find.byKey(const Key('02')), findsWidgets);
  });

  testWidgets('Delete button is present', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: EditGroupPage(group: group))),
    );
    ///I want to be sure that the add button is visualized
    expect(find.text('Delete this Group'), findsOneWidget);
  });
}