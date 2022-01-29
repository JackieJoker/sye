import 'package:flutter/material.dart';
import 'package:sye/Tablet/tablet_home_page.dart';
import 'package:sye/Groups/group_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.orientation == Orientation.portrait
        ? const GroupPage()
        : TabletHomePage();
  }
}
