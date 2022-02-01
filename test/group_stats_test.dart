import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sye/Expenses/expenses_page.dart';
import 'package:sye/Groups/group.dart';
import 'package:sye/Groups/group_stats.dart';
import 'package:sye/balances_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  Group group = const Group(
      id: '01',
      name: 'name',
      description: 'description',
      currency: 'currency',
      category: 'category',
      users: {'u0' : 'user0', 'u1' : 'user1'}
  );
  
  List<ChartData> testList= [ChartData('x', 1), ChartData('y', 6), ChartData('z', 3), ChartData('w', 11)];
  Map testMap = {'x':1, 'y':6, 'z':3};

  testWidgets('Check the group name in the App Bar', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: GroupStats(g: group,),
      )
    );

    expect(find.text(group.getName()), findsOneWidget);
  });

  testWidgets('Check the Visualization of the cake chart', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
          home: GroupStats(g: group,),
        )
    );
    /// Due to an absent connection to the db during testing, the system will display a warning related to
    /// the absence of data from the db
    expect(find.text('Add new expenses to visualize Group Stats!'), findsOneWidget);
  });

  testWidgets('Go back function check', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
          home: GroupStats(g: group,),
        )
    );
    await tester.tap(find.ancestor(of: find.byIcon(Icons.arrow_back_ios_outlined), matching: find.byType(GestureDetector)));
    await tester.pumpAndSettle();
    /// Check only the absence of the page, cannot connecting to the db cause a test error
    expect(find.byType(GroupStats), findsNothing);
  });
  
  test('Test the best payer function', () {
    String result = getBestPayer(testList);
    expect(result, 'w');
  });

  test('Test the getTotal function', () {
    double result = getTotal(testList);
    expect(result, 21);
  });

  test('Test the map-list converter', () {
    List result = getUsers(testMap);
    int i = 0;
    testMap.forEach((key, value) {
      expect(result[i], value);
      i++;
    });
  });
  
  
}