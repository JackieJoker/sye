import 'package:flutter/material.dart';
import 'package:sye/Groups/edit_group_page.dart';
import 'package:sye/Groups/group_dialog.dart';
import 'package:sye/Groups/groups_list.dart';
import 'package:sye/Tablet/full_screen.dart';

import '../auth_gate.dart';
import 'group_widget.dart';

class TabletHomePage extends StatelessWidget {
  TabletHomePage({Key? key}) : super(key: key);

  final ValueNotifier<GroupWidget?> _rightSide = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Split Your Expenses"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                askedToLead(context);
              },
              icon: const Icon(
                Icons.add_circle_outlined,
                color: Colors.white,
              )),
          ValueListenableBuilder<GroupWidget?>(
            valueListenable: _rightSide,
            builder: (BuildContext context, value, Widget? child) {
              if (value == null) {
                return const SizedBox.shrink();
              } else {
                return IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditGroupPage(
                                  group: _rightSide.value!.group)));
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ));
              }
            },
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AuthGate()));
              },
              icon: const Icon(
                Icons.account_circle,
                color: Colors.white,
              )),
        ],
      ),
      body: Row(
        children: [
          Flexible(
            flex: 1,
            child: GroupsList(notifier: _rightSide),
          ),
          const VerticalDivider(width: 3, thickness: 3, color: Colors.indigo),
          Flexible(
            flex: 2,
            child: MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.indigo,
              ),
              home: FullScreen(
                child: ValueListenableBuilder<GroupWidget?>(
                  valueListenable: _rightSide,
                  builder: (BuildContext context, value, Widget? child) {
                    if (value == null) {
                      return Container();
                    } else {
                      while (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                      return value.widget;
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
