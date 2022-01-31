import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sye/Classes/swipeable_item.dart';
import 'package:sye/Expenses/expense.dart';
import 'package:sye/Expenses/expense_detail_page.dart';
import 'package:sye/Expenses/expense_element.dart';
import 'package:sye/Expenses/expenses_list.dart';
import 'package:sye/Expenses/expenses_page.dart';
import 'package:sye/Expenses/new_expense_page.dart';
import 'package:sye/Groups/group.dart';
import 'package:sye/Groups/group_dialog.dart';
import 'package:sye/Groups/group_page.dart';
import 'package:sye/Groups/group_visualizer.dart';
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
  Map groupMap = group.toMap();

  Group group1 = const Group(
      id: '01',
      name: 'name',
      description: '',
      currency: 'currency',
      category: 'category',
      users: {'u0' : 'user0', 'u1' : 'user1'}
  );

  Map group1Map = group1.toMap();

  testWidgets('Add button is present', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: GroupPage(),
      ),
    );
    ///I want to be sure that the add button is visualized
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Group visualizer group name check', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GroupVisualizer(route: groupMap, k: group.getId(),),
        ),
      )
      );
    /// I need to check if the visualizer displays group name
    expect(find.text(group.getName()), findsOneWidget);
  });

  testWidgets('Group visualizer description check', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupVisualizer(route: groupMap, k: group.getId(),),
          ),
        )
    );
    /// I need to check if the visualizer displays the correct value of the description
    expect(find.text(group.getDescription()), findsOneWidget);
  });

  testWidgets('Group visualizer description check', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupVisualizer(route: group1Map, k: group.getId(),),
          ),
        )
    );
    /// I need to check if the visualizer displays the correct value of the description
    expect(find.text('No description'), findsOneWidget);
  });

  /*testWidgets('Add button display the form page after is triggered',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: GroupPage(),
          ),
        );

        await tester.tap(find.byIcon(Icons.add));
        //await tester.pumpAndSettle();

        ///I want to be sure that the new page is visualized
        expect(find.byType(SimpleDialog), findsOneWidget);

        ///I want to be sure that the old page is not anymore visualized
        expect(find.byType(GroupPage), findsNothing);
      });

  testWidgets('GroupList is present', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: GroupPage(),
      )
    );

    ///I want to be sure that the add button is visualized
    expect(find.byType(GroupsList), findsOneWidget);
  });*/
}