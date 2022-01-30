import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:sye/Db/db.dart';

class SelectUserPage extends StatelessWidget {
  final String code;

  const SelectUserPage(this.code, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(DB.getUsersList(code) == null) {
      return const SizedBox.shrink();
    }
    return FirebaseDatabaseQueryBuilder(
        query: DB.getUsersList(code)!,
        builder: (BuildContext context, FirebaseQueryBuilderSnapshot snapshot,
            Widget? child) {
          if (snapshot.isFetching) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          List<DataSnapshot> data = snapshot.docs;
          List<String> result = [];
          for (int i = 0; i < data.length; i++) {
            result.add(data[i].value as String);
          }
          print(result);
          return Scaffold(
              appBar: AppBar(
                title: const Text('Select a user'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_outlined, size: 20,),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Who are you?",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      ...result
                          .map((e) => InkWell(
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                    e.toString(),
                                  ),
                                ),
                              ),
                              onTap: () {
                                DB.importGroup(code);
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              }))
                          .toList()
                    ],
                  ),
                ),
              ));
        });
  }
}
