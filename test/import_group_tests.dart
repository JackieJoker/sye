import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sye/Groups/group_page.dart';
import 'package:sye/Groups/import_group_page.dart';
import 'package:sye/Groups/new_group_form_page.dart';

void main() {
  testWidgets('Selection new/import group is present', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GroupPage()));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('New group'), findsOneWidget);
    expect(find.text('Import a group'), findsOneWidget);
  });

  testWidgets('Tap on new group navigate to NewGroupPage', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GroupPage()));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.text('New group'));
    await tester.pumpAndSettle();

    ///I want to be sure that the new page is visualized
    expect(find.byType(NewGroupFormPage), findsOneWidget);

    ///I want to be sure that the old page is not anymore visualized
    expect(find.byType(GroupPage), findsNothing);
  });

  testWidgets('Tap on import group navigate to ImportPage', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GroupPage()));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.text('Import a group'));
    await tester.pumpAndSettle();

    ///I want to be sure that the new page is visualized
    expect(find.byType(ImportGroupPage), findsOneWidget);

    ///I want to be sure that the old page is not anymore visualized
    expect(find.byType(GroupPage), findsNothing);
  });

  testWidgets('Back navigation in ImportGroup', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ImportGroupPage()));

    await tester.tap(find.byIcon(Icons.arrow_back_ios_outlined));
    await tester.pumpAndSettle();

    ///I want to be sure that the new page is visualized
    expect(find.byType(MaterialApp), findsOneWidget);

    ///I want to be sure that the old page is not anymore visualized
    expect(find.byType(ImportGroupPage), findsNothing);
  });

  testWidgets('Input form present', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ImportGroupPage()));

    ///I want to be sure that the new page is visualized
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Empty string is invalid', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ImportGroupPage()));

    await tester.enterText(find.byType(TextField), '');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    ///I want to be sure that the old page is not anymore visualized
    expect(find.byType(ImportGroupPage), findsOneWidget);
  });
}
