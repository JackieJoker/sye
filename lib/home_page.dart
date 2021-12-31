import 'package:flutter/material.dart';
import 'package:sye/Expenses/expenses_page.dart';
import 'package:sye/Groups/group.dart';
import 'package:sye/tablet_layout.dart';
import 'package:sye/Groups/group_page.dart';

import 'Groups/groups_list.dart';

class HomePage extends StatelessWidget {
  static const String _groupId = 't1';
  static const String _groupCurrency = 'USD';
  static const Map<String, dynamic> _groupParticipants = <String, dynamic>{
    'u1': 'Danilo',
    'u2': 'Alessandro',
    'u3': 'Mattia'
  };
  static const Group _group = Group(
      name: 'Gruppo di prova', currency: 'USD', users: _groupParticipants, id: _groupId, description: "");

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: Don't pass _groupCurrency, access it by _group.groupCurrency
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.orientation == Orientation.portrait
        ? const GroupPage()
        : const TabletLayout(
            groupId: _groupId,
            groupCurrency: _groupCurrency,
            group: _group,
          );
  }
}
