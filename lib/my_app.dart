import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        primarySwatch: Colors.indigo,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.light,
      /* ThemeMode.system to follow system theme,
         ThemeMode.light for light theme,
         ThemeMode.dark for dark theme
      */
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }


}

//TODO: login page, then handle the logged user
//TODO: recognize a user in a group
//TODO: create the balance page, insert a balance for each user of the group
//TODO: adjust the app

