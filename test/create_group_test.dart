import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sye/Groups/group_page.dart';
import 'package:sye/Groups/groups_list.dart';
import 'package:sye/Groups/new_group_form_page.dart';

void main() {
  
  testWidgets('Check the existence of the cancel button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: NewGroupFormPage())),
    );
    /// I want to find the two text elements
    expect(find.widgetWithText(GestureDetector, 'Cancel'), findsOneWidget);
  });

  testWidgets('Check the existence of the save button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: NewGroupFormPage())),
    );
    /// I want to find the two text elements
    expect(find.widgetWithText(GestureDetector, 'Save'), findsOneWidget);
  });
  
  testWidgets('Check the go back function of Cancel button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: NewGroupFormPage())),
    );
    await tester.tap(find.descendant(of: find.byType(TextButton), matching: find.text('Cancel')));
    await tester.pumpAndSettle();

    ///I want to be sure that the new page is visualized
    expect(find.byType(GroupsList), findsOneWidget);

    ///I want to be sure that the old page is not anymore visualized
    expect(find.byType(NewGroupFormPage), findsNothing);
  });
  
  testWidgets('Check the display of the Add button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: NewGroupFormPage())),
    );
    
    expect(find.text('Add'), findsOneWidget);
  });

  testWidgets('Check the adding of a new user in the list', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: NewGroupFormPage())),
    );

    /// Enter the user Ale in the Text Field
    await tester.enterText(find.byKey(const Key('01')), 'Ale');
    await tester.scrollUntilVisible(find.byKey(const Key('01')), 0);
    await tester.tap(find.ancestor(of: find.text('Add'), matching: find.byType(GestureDetector)));

    /// Check if it shows up
    expect(find.byKey(const Key('02')), findsWidgets);
  });
}