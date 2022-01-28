import 'package:flutter/material.dart';

import 'import_group_page.dart';
import 'new_group_form_page.dart';

Future<void> askedToLead(context) async {
  switch (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 1);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'New group',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 2);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Import a group',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        );
      })) {

    /// If user select the first option
    case 1:
      Navigator.push(
          context,
          MaterialPageRoute(
              //builder: (context) => NewGroupPage()));
              builder: (context) => NewGroupFormPage()));
      break;

    /// If user select the first option
    case 2:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ImportGroupPage()));
      break;
    case null:
      break;
  }
}
