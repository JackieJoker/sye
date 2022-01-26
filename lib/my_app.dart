import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Groups/group_page.dart';
import 'get_device_id.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _storeUser();
    return MaterialApp(
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
        Locale('fa', ''),
        Locale('fr', ''),
        Locale('ja', ''),
        Locale('pt', ''),
        Locale('sk', ''),
        Locale('pl', ''),
      ],
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Split Your Expenses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }

  _storeUser() async{
    final prefs = await SharedPreferences.getInstance();
    try {
      var id = await DeviceId.getDeviceDetails();
      prefs.setString('deviceId', id);
      //log(prefs.getString('deviceId')!);
    } on Exception catch (e) {
      // TODO
    }
  }
}

//TODO: login page, then handle the logged user
//TODO: recognize a user in a group
//TODO: create the balance page, insert a balance for each user of the group
//TODO: adjust the app

