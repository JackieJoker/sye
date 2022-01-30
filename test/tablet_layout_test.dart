import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sye/Groups/group_page.dart';
import 'package:sye/Groups/groups_list.dart';
import 'package:sye/Tablet/tablet_home_page.dart';
import 'package:sye/home_page.dart';

void main() {
  testWidgets('GroupsList is present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TabletHomePage()));

    expect(find.byType(GroupsList), findsOneWidget);
  });

  testWidgets('Add button is present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TabletHomePage()));

    expect(find.byIcon(Icons.add_circle_outlined), findsOneWidget);
  });

  testWidgets('Edit button appears only when an expense is selected',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: TabletHomePage()));

        expect(find.byIcon(Icons.edit), findsNothing);
      });

  final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding
      .ensureInitialized() as TestWidgetsFlutterBinding;

  testWidgets('Portrait correctly renderized', (WidgetTester tester) async {
    binding.window.physicalSizeTestValue = Size(800, 1600);
    binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.byType(TabletHomePage), findsNothing);
    expect(find.byType(GroupPage), findsOneWidget);
  });

  testWidgets('Landscape correctly renderized', (WidgetTester tester) async {
    binding.window.physicalSizeTestValue = Size(1600, 800);
    binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.byType(TabletHomePage), findsOneWidget);
    expect(find.byType(GroupPage), findsNothing);
  });

  testWidgets('Screen rotation changes layout', (WidgetTester tester) async {
    binding.window.physicalSizeTestValue = Size(800, 1600);
    binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.byType(TabletHomePage), findsNothing);
    expect(find.byType(GroupPage), findsOneWidget);

    binding.window.physicalSizeTestValue = Size(1600, 800);
    binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pump();

    expect(find.byType(TabletHomePage), findsOneWidget);
    expect(find.byType(GroupPage), findsNothing);
  });
}
